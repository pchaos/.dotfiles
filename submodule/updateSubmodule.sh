#!/bin/bash
# Last Modified: 2023-06-16 09:58:19
# 更新目录下的版本

# 禁用 SC2145 警告
# shellcheck disable=SC2145
green() { echo -e "\e[32m$@\e[0m" ; }
yellow() { echo -e "\e[33m$@\e[0m"; }

for dir in */; do
  if [[ "$dir" != "exclude_dir/" ]]; then
    (
      cd "${dir}"
      yellow "${dir} start!\n"
      # 在子目录中执行操作
      git pull
      green "${dir} Done!\n"
      # cd ..
    )
  fi
done
