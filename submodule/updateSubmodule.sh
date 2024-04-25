#!/bin/bash
# Last Modified: 2024-04-25 23:37:57
# 更新目录下的版本

# Fetch New Changes: If you want to fetch the latest changes from the upstream repositories of all submodules and update them to the latest commit on their respective branches (not just the commit recorded in the main project), use:
git submodule update --remote


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
