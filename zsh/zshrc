# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
autoload -U colors && colors
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

source  "$HOME/.aliases"

# Prompt function
function git_info() {
    eval branch=$(git branch 2> /dev/null | grep ^\* | cut -b 3-)

    if [[ $branch != "" ]]; then
        print "[%{$fg[red]%}±%{$reset_color%}%{$fg[magenta]%}$branch%{$reset_color%}]"
    fi
}

function last_status() {
    eval result='%?'
    print $result
}

# Prompt
export PROMPT="(%{$fg[red]%}%h%{$reset_color%})[%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}:%{$fg[yellow]%}%~%{$reset_color%}|%{$fg[cyan]%}%*%{$reset_color%}]$(eval git_info)%# "
export RPROMPT="$(last_status)"

# Export some env vars
export EDITOR=vim

path=($path $HOME/.bin/ /opt/)

