#!/bin/bash

# 设置颜色变量
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
RESET='\033[0m'

# 设置初始行数
INITIAL_LINES=100

# 设置日志文件路径
LOG_FILE="build.log"

# 处理日志的函数
process_with_awk() {
    awk '
BEGIN {
    # 定义颜色函数
    function clr(color, text) {
        return color text RESET
    }
}

{
    raw = $0

    # 去除 ANSI 转义码
    gsub(/\x1B\[[0-?]*[ -/]*[@-~]/, "", raw)

    # 处理日志行
    if (raw ~ /^(\033\[90m)?go:(\033\[0m)? downloading/) {
        sub(/downloading/, clr("32","&"), raw)
        raw = gensub(/ (v[0-9][a-zA-Z0-9._-]*)/, " " clr("34","\\1"), "g", raw)
        raw = gensub(/ ([a-zA-Z0-9._\/-]+\.[a-zA-Z]{2,}[a-zA-Z0-9._\/-]*)/, " " clr("36","\\1"), "g", raw)
    }

    print raw
}'
}

# 主函数
main() {
    # 检测是否进入管道模式
    local is_pipe=0
    if [ ! -t 0 ]; then
        if [ $# -eq 0 ] || [ ! -f "$1" ]; then
            is_pipe=1
        fi
    fi

    if [ "$is_pipe" -eq 1 ]; then
        SAVE_TO="${1:-$LOG_FILE}"
        echo -e "${BLUE}信息: 管道模式启动，原始日志将保存至: ${CYAN}${SAVE_TO}${RESET}" >&2
        tee "$SAVE_TO" | process_with_awk
        exit 0
    fi

    if [ $# -eq 0 ]; then
        show_header
        show_usage
        exit 0
    fi

    if [ ! -f "$LOG_FILE" ]; then
        echo -e "${RED}错误: 文件不存在: ${LOG_FILE}${RESET}"
        show_usage
        exit 1
    fi
    
    show_header
    
    echo -e "${CYAN}显示最后 ${INITIAL_LINES} 行:${RESET}"
    echo "----------------------------------------"
    
    tail -n "$INITIAL_LINES" "$LOG_FILE" 2>/dev/null | process_with_awk
    
    echo "----------------------------------------"
    echo -e "${GREEN}开始实时监控...${RESET}"
    echo ""
    
    trap 'echo -e "\n${GRAY}监控已停止${RESET}"; exit 0' INT
    
    tail -f "$LOG_FILE" 2>/dev/null | process_with_awk
}

main "$@"
