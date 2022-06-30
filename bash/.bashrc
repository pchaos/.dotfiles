# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH:$HOME/.cargo/bin"
fi
if [[ "$PATH" == *"$cargo"* ]]; then
    PATH="$PATH:$HOME/.cargo/bin"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# User specific aliases and functions

# Add Timestamp to Terminal
#export PROMPT_COMMAND="echo -n \[\$(date +%H:%M:%S:%3N)\]\ "

source ~/.local/bin/bashmarks.sh
. ~/.local/bin/myEnv.sh
#macchanger -s enp2s0f1
#macchanger -s wlp3s0

# 输入法 
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS="@im=fcitx"

# export PATH="usr/local/texlive/2020/bin/x86_64-linux:$PATH"

 [[ -s "$HOME/.xmake/profile" ]] && source "$HOME/.xmake/profile" # load xmake profile

# changes the terminal window title bar text to the current time once 60 second.
# while true; do
    # printf '\e]0;%s\a' $(date +%T)
    # sleep 60
# done &

# alacritty
# export ALACRITTY=
# source ~/.bash_completion/alacritty

# [ -d '/home/myuser/software/python3rd/anaconda/envs/hikyuu' ] && conda activate hikyuu

# Vim Mode On The Command Line In Bash
# set -o vi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/myuser/software/python3rd/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/myuser/software/python3rd/anaconda/etc/profile.d/conda.sh" ]; then
        . "/home/myuser/software/python3rd/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/myuser/software/python3rd/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

source ~/.alacritty
