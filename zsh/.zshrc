HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# for private zsh file
ZSH_DIR="${HOME}/.zsh"

if [ -d $ZSH_DIR ] && [ -r $ZSH_DIR ] && [ -x $ZSH_DIR ]; then
    for file in ${ZSH_DIR}/**/*.zsh; do
        [ -r $file ] && source $file
    done
fi

# for ghq
function _fzf_cd_ghq() {
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
    local root="$(ghq root)"
    local repo="$(ghq list | fzf --preview="ls -AF --color=always ${root}/{1}")"
    local dir="${root}/${repo}"
    [ -n "${dir}" ] && cd "${dir}"
    zle accept-line
    zle reset-prompt
}

zle -N _fzf_cd_ghq
bindkey "^h" _fzf_cd_ghq

alias gc="gcloud config list"
alias gmoji="gitmoji -c"
alias h=helm
alias hf=helmfile
alias k=kubectl
alias myip="curl -s https://httpbin.org/ip | jq ."
alias t=terraform
alias tapply="terraform apply"
alias tplan="terraform plan"
alias vim=nvim
alias zs="source ~/.zshrc"

export DENO_INSTALL="/Users/takaaki-abe/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH=~/bin:$PATH

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
