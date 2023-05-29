#!/bin/bash
# Last Modified: 2023-05-29 10:11:59
# 更新目录下的版本
#

green() { echo -e "\e[32m$@\e[0m" ; }
yellow() { echo -e "\e[33m$@\e[0m"; }

for dir in */; do
  if [[ "$dir" != "exclude_dir/" ]]; then
    cd "${dir}"
    green "${dir} start!\n"
    # 在子目录中执行操作
    git pull 
    yellow "${dir} Done!\n"
    cd ..
  fi
done

