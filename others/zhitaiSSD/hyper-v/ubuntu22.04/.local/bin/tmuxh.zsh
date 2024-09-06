# #!/usr/bin/env bash

# Last Modified: 2024-08-26 21:33:26
# Setup a work space called `work` with two windows
# first window has 2 panes.
# The first pane set at 65%, split horizontally, set to api root and running vim
# pane 2 is split at 25% and running redis-server
# pane 3 is set to api root and bash prompt.
# note: `api` aliased to `cd ~/path/to/work`
#

# default for hikyuu
pyenv=${1:-hikyuu}
session="remote_${USER}_${pyenv}"

alias importTDX="python hikyuu/gui/importdata.py"

# Check if the session exists, discarding output
# We can check $? for the exit status (zero for success, non-zero for failure)
tmux has-session -t $session 2>/dev/null
if [ $? != 0 ]; then

  # set up tmux
  tmux start-server

  # create a new tmux session, starting vim from a saved session in the new window
  # tmux new-session -d -s $session -n vim #"vim -S ~/.vim/sessions/kittybusiness"
  tmux new-session -d -s $session
  echo "new-session ${session}"

  # Select pane 1, set dir to api, run vim
  tmux selectp -t 0

  # Split pane 1 horizontal by 65%, start redis-server
  tmux splitw -h
  tmux selectp -t 0
  tmux send-keys "cd ~/hikyuu" C-m
  # $CONDA_PREFIX_1 ：anaconda安装目录
  # shell_case ' tmux send-keys "source $HOME/.local/bin/hikyuu_env.zsh ${pyenv}" C-m'  'tmux send-keys "source $HOME/.local/bin/hikyuu_env.sh ${pyenv}" C-m'
  # tmux send-keys "source $HOME/.local/bin/hikyuu_env.zsh ${pyenv}" C-m
  tmux send-keys "conda activate ${pyenv}" C-m

  tmux send-keys 'echo $PATH;sleep 1.0 && echo ""' C-m

  # Select pane 2
  tmux selectp -t 1

  # tmux send-keys "api" C-m
  # tmux send-keys "$SOURCE_POWERLINE" C-m
  tmux send-keys "cd ~/hikyuu_hub" C-m
  tmux send-keys "curl wttr.in" C-m
  # tmux send-keys "g hikyuuother" C-m
  # tmux send-keys "sourceo $PATH;sleep 1.5 && echo ""
  # $HOME/.local/bin/hikyuu_env.sh ${pyenv}" C-m
  # tmux send-keys "source $HOME/.local/bin/hikyuu_env.zsh ${pyenv}" C-m
  tmux send-keys "conda activate ${pyenv}" C-m
  # show time
  sleep 1 && tmux clock-mode -t 1

  # 设置vi快捷键模式
  tmux set-window-option -g mode-keys vi
  tmux set -g mouse on

  tmux selectp -t 0
  sleep 0.3 
fi

# Finished setup, attach to the tmux session!
tmux attach-session -t $session
