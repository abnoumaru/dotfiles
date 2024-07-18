HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

if type brew &>/dev/null; then
    if [ -d "$(brew --prefix)/share/zsh/site-functions" ]; then
        FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    fi
    if [ -d "$(brew --prefix)/opt/zsh-completion/share/zsh-completions" ]; then
        FPATH=$(brew --prefix)/opt/zsh-completion/share/zsh-completions:$FPATH
    fi

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
    [ -n "${repo}" ] && [ -n "${dir}" ] && cd "${dir}"
    zle accept-line
    zle reset-prompt
}

zle -N _fzf_cd_ghq
bindkey "^h" _fzf_cd_ghq

# alias
alias gc="gcloud config list"
alias k=kubectl
alias myip="curl -s https://httpbin.org/ip | jq ."
alias t=terraform
alias tapply="terraform apply"
alias tplan="terraform plan"
alias vim=nvim
alias zs="source ~/.zshrc"

# export 
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH=~/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
