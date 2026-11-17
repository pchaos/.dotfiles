# !/usr/bin/env bash
: <<COMMENT
Modified: 2026-11-17 13:41:09
systemctl --user start rclone-onedrive    # 挂载
systemctl --user stop rclone-onedrive     # 卸载（会 fusermount -u）
systemctl --user status rclone-onedrive   # 查看状态
systemctl --user restart rclone-onedrive  # 重启

sudo timeout 30 tcpdump -i any -nn -A -s 0 \                                                                                             ─╯
  'host 192.168.124.87 and tcp port 20128 and (src host 192.168.124.90 or dst host 192.168.124.90)'
COMMENT

# 挂载 rclone-onedrive，成功后备份 firefox.kdbx（保留最近 5 个版本）
# 用法: mount_onedriveap88
mount_onedriveap88() {
    echo "==> start rclone-onedrive service"
    if ! systemctl --user start rclone-onedrive; then
        echo '!! failed to start rclone-onedrive' >&2
        return 1
    fi


    local dir='/mnt/onedrive/ap88yu'
    local tmp i mounted='' dead reason probe alive rc stat
    tmp=$(mktemp) || { echo '!! mktemp failed' >&2; return 1; }
    echo "==> wait for remote content in $dir (5s probes, max 30 attempts)"
    for (( i=1; i<=30; i++ )); do
        # ls 可能卡在挂载点上等远程（甚至 D 状态，连 timeout 都杀不掉）；
        # 后台探测 + ps 轮询：每次 ls 最多 5 秒，函数本身永不冻结。
        # 输出进临时文件：必须列出非空内容才算挂载成功（空目录 = 远端未就绪）。
        ls -A "$dir" >"$tmp" 2>&1 &
        probe=$!
        alive=''
        for delay in 0 2 3; do
            sleep "$delay"
            stat=$(ps -o stat= -p "$probe" 2>/dev/null)
            # 僵尸（Z）也算已结束：wait 收割拿真实退出码，避免误判为挂起
            if [[ -n "$stat" ]] && [[ "$stat" != *Z* ]]; then
                alive=1
            else
                alive=''
                break
            fi
        done
        if [[ -z "$alive" ]]; then
            wait "$probe" 2>/dev/null
            rc=$?
            if (( rc == 0 )) && [[ -s "$tmp" ]]; then
                mounted=1
                break
            fi
            reason='remote content not listed yet (empty)'
        else
            kill -9 "$probe" 2>/dev/null
            # D 状态进程收不到 SIGKILL，而 wait 会随它一起永久阻塞。
            # 轮询最多 1s 等探测退出：非 D 状态（已死/僵尸/将死）立即 wait 回收，
            # 一直停在 D 则放弃 wait，绝不冻结调用方。
            stat=''
            for _ in {1..5}; do
                stat=$(ps -o stat= -p "$probe" 2>/dev/null) || break
                [[ "$stat" != *D* ]] && break
                sleep 0.2
            done
            if [[ "$stat" != *D* ]]; then
                wait "$probe" 2>/dev/null
            fi
            reason='ls hung on mountpoint (unresponsive)'
        fi
        printf '    attempt %02d/30: %s\n' "$i" "$reason"
        if ! systemctl --user is-active --quiet rclone-onedrive; then
            dead=1
            break
        fi
    done
    rm -f "$tmp"
    if [[ -n "$dead" ]]; then
        echo '!! failed to mount onedrive-ap88: rclone-onedrive went inactive' >&2
        return 1
    fi
    if [[ -z "$mounted" ]]; then
        echo '!! failed to mount onedrive-ap88: no content after 30 attempts' >&2
        echo '    hints: systemctl --user status rclone-onedrive' >&2
        echo '           journalctl --user -u rclone-onedrive -n 50 --no-pager' >&2
        return 1
    fi

    echo "==> mountpoint ready: $dir"
    echo "==> check backup source"
    local src="$dir/backup/firefox.kdbx"
    local bdir="$dir/backup"
    if [[ ! -f "$src" ]]; then
        echo "!! warning: $src not found, skip backup" >&2
        return
    fi
    echo "==> choose checksum tool"
    local hashcmd
    if command -v cksum >/dev/null 2>&1; then
        hashcmd='cksum'
    else
        hashcmd='md5sum'
    fi
    echo "==> find latest backup and compare checksums"
    local latest stamp
    latest=$(ls -1t "$bdir"/firefox-*.kdbx 2>/dev/null | head -n1)
    if [[ -n "$latest" ]] && [[ "$($hashcmd < "$src")" == "$($hashcmd < "$latest")" ]]; then
        echo "    firefox.kdbx unchanged vs $latest, skip backup"
        return
    fi
    stamp=$(date +%Y%m%d-%H%M%S)
    echo "==> backup: cp $src -> $bdir/firefox-$stamp.kdbx"
    cp "$src" "$bdir/firefox-$stamp.kdbx"
    echo "==> prune old backups (keep last 5)"
    ls -1t "$bdir"/firefox-*.kdbx 2>/dev/null | tail -n +6 | xargs -r rm --
    echo "!! backed up: firefox-$stamp.kdbx (keep last 5)"
}

# 坚果云
# rclone config create jianguoyun webdav url "https://dav.jianguoyun.com/dav/" vendor other user "ywy01"  pass ""

# https://keepassxc.org
# flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# flatpak install --user flathub org.keepassxc.KeePassXC
