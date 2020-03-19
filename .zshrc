# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


if [ -s ~/.pyenv ]; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"

    eval "$(pyenv virtualenv-init -)"
fi

export PATH="$PATH:/snap/bin:/usr/local/MATLAB/R2018b/bin"

# 色を使用
autoload -Uz colors
colors

# 補完
autoload -Uz compinit
compinit

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct

# cdの後にlsを実行
chpwd() { ls -tr --color=auto }

# プロンプトを2行で表示、時刻を表示
PROMPT="%(?.%{${fg[magenta]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color}(%*%) %~
%# "

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward


export PATH="${PATH}:/home/makino.15083/.local/share/mindmaster-6-amd64"

function print_known_hosts (){
  if [ -f $HOME/.ssh/known_hosts ]; then
    cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
  fi  
}
_cache_hosts=($( print_known_hosts ))

alias alarm="mpg123 ${HOME}/.local/share/alarm/Wecker-sound.mp3"
export PATH="${PATH}:/home/makino.15083/git/sentencepiece/bazel-bin/src"
export LD_LIBRARY_PATH=${HOME}/.local/lib:$LD_LIBRARY_PATH

alias tb='tensorboard --logdir '
alias tb1='tensorboard --port 6007 --logdir '
alias tb2='tensorboard --port 6008 --logdir '
alias tb3='tensorboard --port 6009 --logdir '
alias clip='xsel -bi'

# maven
export JAVA_HOME=/usr/lib/jvm/default-java
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}

# tensorboard
alias tbd='docker run --rm -t -p 6106:6106 -v $PWD:/workspace  tensorflow/tensorflow tensorboard --logdir /workspace --port 6106 --bind_all'
alias tbd1='docker run --rm -t -p 6107:6107 -v $PWD:/workspace  tensorflow/tensorflow tensorboard --logdir /workspace --port 6107 --bind_all'
alias tbd2='docker run --rm -t -p 6108:6108 -v $PWD:/workspace  tensorflow/t    ensorflow tensorboard --logdir /workspace --port 6108 --bind_all'
alias tbd3='docker run --rm -t -p 6109:6109 -v $PWD:/workspace  tensorflow/t    ensorflow tensorboard --logdir /workspace --port 6109 --bind_all'
alias tbd4='docker run --rm -t -p 6110:6110 -v $PWD:/workspace  tensorflow/t    ensorflow tensorboard --logdir /workspace --port 6110 --bind_all'

