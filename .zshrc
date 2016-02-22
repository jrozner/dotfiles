autoload -U compinit; compinit -i
autoload colors; colors

fpath=(/usr/local/share/zsh-completions $fpath)

zstyle ':completion:*' menu select
setopt completealiases

setopt extendedglob

setopt prompt_subst
autoload promptinit; promptinit

export HISTSIZE=10000
export SAVEHIDT=10000
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=$HISTSIZE
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

export LC_CTYPE=en_US.UTF-8
export EDITOR=vim
export GOPATH=$HOME
if [[ -x /usr/libexec/path_helper ]]; then
  PATH=""
  eval $(/usr/libexec/path_helper -s)
  export PATH="$HOME/bin:$GOPATH/bin:$HOME/.rbenv/bin:/usr/local/bin:/usr/local/sbin:$PATH"
fi

if [[ $(uname) == 'Darwin' ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
  export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
  alias ls='ls -G'
fi

if [[ $(uname) == 'Linux' ]]; then
  alias ls='ls --color=auto'
fi

# aliases
alias grep='grep --color=auto'
alias termcover="go tool cover -func=c.out && rm c.out"
alias heatcover="go tool cover -html=c.out && rm c.out"

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "(${ref#refs/heads/})$(parse_git_dirty)"
}

parse_git_dirty() {
  if [[ -n $(git status -s --ignore-submodules=dirty 2> /dev/null) ]]; then
    echo "%{$fg[red]%}✖%{$reset_color%}"
  else
    echo "%{$fg[green]%}✔%{$reset_color%}"
  fi
}

function precmd() {
  PROMPT="%{$fg[red]%}➜ %{$fg[cyan]%}%c%{$fg[blue]%}$(git_prompt_info) %{$fg[green]%}%# %{$reset_color%}"
}

bindkey -e
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey -s '\e.' "..\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
bindkey ' ' magic-space    # also do history expansion on space

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

if [ -d $HOME/.rbenv ]; then
  eval "$(rbenv init -)"
fi

if [ -f $HOME/.zsh_local ]; then
  source $HOME/.zsh_local
fi
