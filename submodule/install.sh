#!/bin/bash

# git clone https://github.com/chris-marsh/pureline.git
cp pureline/configs/powerline_full_256col.conf ~/.pureline.conf
if ! grep ".pureline.conf" ~/.bashrc; then
  echo "write to ~/.bashrc"
  echo '# tmux 不能识别pureline prompt
export PROMPT_COMMAND_old=$PROMPT_COMMAND
if [ "$TERM" != "linux" ]; then
    source $PWD/pureline/pureline ~/.pureline.conf
fi' |tee -a ~/.bashrc
  local str='s|$PWD|dirs|'
  sedstr=$(echo "${str/dirs/$PWD}")
  sed -i "$sedstr" ~/.bashrc
fi
