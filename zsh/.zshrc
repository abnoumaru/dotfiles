# Encoding
setopt print_eight_bit

# History
# ref: https://zenn.dev/botamotch/articles/e7960f0dc84d8b
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history

# Homebrew completions
for dir in /opt/homebrew/share/zsh/site-functions /opt/homebrew/share/zsh-completions; do
  [ -d "$dir" ] && FPATH="$dir:$FPATH"
done
autoload -Uz compinit
compinit

# Basic paths
export GPG_TTY=$(tty)
export PATH="$PATH:$HOME/.local/bin"

# Other tools
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
[ -d "$TF_PLUGIN_CACHE_DIR" ] || mkdir -p "$TF_PLUGIN_CACHE_DIR"

# fzf configuration
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#c5c9c5,fg+:#c5c9c5,bg:-1,bg+:#282727
  --color=hl:#8ba4b0,hl+:#8ea4a2,info:#c4b28a,marker:#87a987
  --color=prompt:#c4746e,spinner:#8992a7,pointer:#8992a7,header:#949fb5
  --color=border:#393836,label:#a6a69c,query:#c5c9c5
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

# Tool Initializations
eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(uv generate-shell-completion zsh)"

# ls colors for macOS
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -G'

# Git aliases
alias cb="git rev-parse --abbrev-ref HEAD | tee /dev/tty | pbcopy"
alias d="git diff"
alias st="git status -sb"
alias sw="git switch"

alias vim=nvim
alias zs="source ~/.zshrc"

# Copy command output and the command itself to clipboard
cmdcp() {
  local cmd="$@"
  {
    echo "$ $cmd"
    echo ""
    eval "$cmd"
  } | pbcopy
  echo "✓ Copied to clipboard"
}
# ghq repository selection
# ref: https://gist.github.com/sheepla/d680f1480d8c36c4290d6aabebf1abc6
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
# ref: https://zenn.dev/nokogiri/articles/ec99e40df54555
function _fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse --no-sort)
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N _fzf-select-history
bindkey '^r' _fzf-select-history

# Claude Code session selection
function _claude_resume() {
  BUFFER="claude --resume"
  zle accept-line
}
zle -N _claude_resume
bindkey '^o' _claude_resume

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
