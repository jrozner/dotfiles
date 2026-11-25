typeset -U path fpath

export LC_CTYPE=en_US.UTF-8
# must assign the path array, not PATH, for typeset -U to dedupe
path=($HOME/.local/bin $HOME/bin $HOME/go/bin $HOME/.cargo/bin /usr/local/bin /usr/local/sbin $path)

if [[ $OSTYPE == darwin* ]]; then
  export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
  export HOMEBREW_NO_ENV_HINTS=1
  export HOMEBREW_NO_ANALYTICS=1
  alias ls='ls -G'
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x $b ]] && { eval "$($b shellenv)"; break }
  done
  unset b
elif [[ $OSTYPE == linux* ]]; then
  alias ls='ls --color=auto'
fi

for d in /opt/homebrew/share/zsh-completions /usr/local/share/zsh-completions; do
  [[ -d $d ]] && fpath=($d $fpath)
done
unset d

autoload -U compinit; compinit -i
autoload -U colors; colors

zstyle ':completion:*' menu select

setopt interactive_comments

HISTSIZE=12000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# use neovim if we have it
if (( $+commands[nvim] )); then
  export EDITOR=nvim
  alias vim=nvim
else
  export EDITOR=vim
fi

# aliases
alias grep='grep --color=auto'
ccscratch()    { cd "$(mktemp -d)" && claude "$@" }
codexscratch() { codex -C "$(mktemp -d)" "$@" }

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b)%m'
zstyle ':vcs_info:git:*' actionformats '(%b|%a)%m'
zstyle ':vcs_info:git*+set-message:*' hooks git-dirty

function +vi-git-dirty() {
  # escape % in branch names
  hook_com[branch]=${hook_com[branch]//\%/%%}
  if [[ -n $(git status --porcelain --ignore-submodules=dirty 2> /dev/null) ]]; then
    hook_com[misc]="%{$fg[red]%}✖%{$reset_color%}"
  else
    hook_com[misc]="%{$fg[green]%}✔%{$reset_color%}"
  fi
}

function _prompt_precmd() {
  vcs_info
  PROMPT="%{$fg[red]%}➜ %{$fg[cyan]%}%c%{$fg[blue]%}${vcs_info_msg_0_} %{$fg[green]%}%# %{$reset_color%}"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_precmd

bindkey -e
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# up/down prefix search; ^[OA is what arrows send in application mode (Ubuntu)
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for k in '^[[A' '^[OA'; do bindkey "$k" up-line-or-beginning-search; done
for k in '^[[B' '^[OB'; do bindkey "$k" down-line-or-beginning-search; done
unset k

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
bindkey "^[[3~" delete-char

if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

# re-dedupe after brew shellenv / .zshrc.local
path=($path)
