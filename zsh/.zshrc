# ================================
#        Basic Shell Settings
# ================================
# Encoding
setopt print_eight_bit

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history

# ================================
#         Completions
# ================================
# Homebrew completions
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

# ================================
#         Environment Variables
# ================================
# Basic paths
export GPG_TTY=$(tty)
export PATH=~/bin:$PATH
export PATH="$PATH:$HOME/.local/bin"

# Development tools
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Claude Code settings
export CLAUDE_CODE_AUTO_UPDATE=false
export DISABLE_INTERLEAVED_THINKING=1
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=true

# Other tools
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# fzf configuration
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-bold" --prompt=">>> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Rancher Desktop
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/takaaki-abe/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# ================================
#         Tool Initializations
# ================================
eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(nodenv init - zsh)"

# ================================
#         Aliases
# ================================
# ls colors for macOS
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -G'

# Git aliases
alias cb="git rev-parse --abbrev-ref HEAD | tee /dev/tty | pbcopy"
alias d="git diff"
alias st="git status -sb"
alias sw="git switch"

alias gc="gcloud config list"
alias k=kubectl
alias m="curl -s https://httpbin.org/ip | jq ."
alias vim=nvim
alias zs="source ~/.zshrc"

# ================================
#         Functions & Keybindings
# ================================
# ghq repository selection
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

# History selection
function _fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse --no-sort)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N _fzf-select-history
bindkey '^r' _fzf-select-history

# Repository file edit
function _fzf-repo-edit() {
    # 除外するディレクトリのパターン
    local exclude_dirs=(
        ".git"
        "node_modules"
        ".next"
        "dist"
        "build"
        "coverage"
        ".cache"
        "vendor"
        "__pycache__"
        ".pytest_cache"
        ".mypy_cache"
        ".tox"
        ".venv"
        "venv"
        ".env"
    )
    
    # 除外パターンを作成
    local exclude_pattern=""
    for dir in "${exclude_dirs[@]}"; do
        exclude_pattern="$exclude_pattern -name '$dir' -prune -o"
    done
    
    # findとfzfを使ってファイルを選択 (ctrl-oでGitHubを開く)
    local out=$(eval "find . $exclude_pattern -type f -print" | fzf --expect=ctrl-o --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {}' --preview-window=right:60%)
    
    # fzfの出力を解析
    local key=$(echo "$out" | head -1)
    local selected=$(echo "$out" | tail -n +2)
    
    if [ -n "$selected" ]; then
        if [ "$key" = "ctrl-o" ]; then
            # GitHubのリポジトリURLを取得してファイルのURLを構築
            local remote_url=$(git remote get-url origin 2>/dev/null)
            if [ -n "$remote_url" ]; then
                # SSH形式をHTTPS形式に変換
                local github_url=$(echo "$remote_url" | sed -e 's/git@github.com:/https:\/\/github.com\//' -e 's/\.git$//')
                
                # 現在のブランチを取得
                local branch=$(git branch --show-current 2>/dev/null || echo "main")
                
                # 相対パスを取得
                local relative_path="${selected#./}"
                
                # GitHubのファイルURLを開く
                local file_url="${github_url}/blob/${branch}/${relative_path}"
                open "$file_url"
            else
                echo "Git remote not found"
            fi
        else
            # 通常の動作: Vimで開く
            vim "$selected" < /dev/tty > /dev/tty
        fi
    fi
    zle reset-prompt
}
zle -N _fzf-repo-edit
bindkey '^f' _fzf-repo-edit

# ================================
#         Private Configurations
# ================================
# Load private zsh files
ZSH_DIR="${HOME}/.zsh"
if [ -d $ZSH_DIR ] && [ -r $ZSH_DIR ] && [ -x $ZSH_DIR ]; then
    for file in ${ZSH_DIR}/**/*.zsh; do
        [ -r $file ] && source $file
    done
fi

