# Interactive bash defaults inspired by the local zsh setup.

umask 022
ulimit -c 0 2>/dev/null || true

set -o histexpand

export HISTFILE="${HISTFILE:-$HOME/.bash_history}"
export HISTSIZE=1000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:[ ]*"
export PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

git_prompt_branch() {
    local branch
    branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)" || return
    printf " %s" "$branch"
}

if [ -n "${BASH_VERSION:-}" ]; then
    # Keep only the last two path components in the prompt.
    PROMPT_DIRTRIM=1
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[01;33m\]$(git_prompt_branch)\[\033[00m\] \$ '
fi

[ -f "$HOME/.fzf.bash" ] && . "$HOME/.fzf.bash"
