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

# Claude Code settings
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
eval "$(uv generate-shell-completion zsh)"

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

  local exclude_pattern=""
  for dir in "${exclude_dirs[@]}"; do
    exclude_pattern="$exclude_pattern -name '$dir' -prune -o"
  done

  local out=$(eval "find . $exclude_pattern -type f -print" | fzf --expect=ctrl-o --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {}' --preview-window=right:60%)

  local key=$(echo "$out" | head -1)
  local selected=$(echo "$out" | tail -n +2)

  if [ -n "$selected" ]; then
    if [ "$key" = "ctrl-o" ]; then
      local remote_url=$(git remote get-url origin 2>/dev/null)
      if [ -n "$remote_url" ]; then
        local github_url=$(echo "$remote_url" | sed -e 's/git@github.com:/https:\/\/github.com\//' -e 's/\.git$//')
        local branch=$(git branch --show-current 2>/dev/null || echo "main")
        local relative_path="${selected#./}"
        local file_url="${github_url}/blob/${branch}/${relative_path}"
        open "$file_url"
      else
        echo "Git remote not found"
      fi
    else
      echo -n "$selected" | pbcopy
      vim "$selected" < /dev/tty > /dev/tty
    fi
  fi
  zle reset-prompt
}
zle -N _fzf-repo-edit
bindkey '^f' _fzf-repo-edit

# knqyf263/pet
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select

function gen-ai-commit-msg() {
  local DIFF AI_COMMIT_MSG COMMIT_FILE RAW

  echo "Generate a commit message for staged changes."

  DIFF=$(git diff --staged)

  if [ -z "$DIFF" ]; then
  echo "No staged changes found. Please 'git add' files first." >&2
  return 1
  fi

  COMMIT_FILE=$(mktemp)
  trap 'rm -f "${COMMIT_FILE}"' EXIT

  echo "愛季「あーコミットメッセージかぁ。あいでぃに任せて！」"
  echo

  if command -v wezterm &> /dev/null; then
    ZSHRC_FILE="${(%):-%x}"
    if [ -L "$ZSHRC_FILE" ]; then
      ZSHRC_FILE=$(readlink "$ZSHRC_FILE")
    fi
    DOTFILES_DIR=$(cd "$(dirname "$ZSHRC_FILE")" && pwd)
    IMAGES_DIR="${DOTFILES_DIR}/images"
    if [ -d "${IMAGES_DIR}" ]; then
      # Find all GIF files and select one randomly
      GIF_FILES=("${IMAGES_DIR}"/*.gif)
      if [ -f "${GIF_FILES[1]}" ]; then
        # Select random GIF file
        RANDOM_GIF=$(printf '%s\n' "${GIF_FILES[@]}" | shuf -n 1)
        if [ -f "${RANDOM_GIF}" ]; then
          wezterm imgcat "${RANDOM_GIF}" 2>/dev/null || true
        fi
      fi
    fi
  fi

  RAW=$(
    {
      cat <<'PROMPT'
Output ONLY the commit message enclosed strictly between these tags:
<commit_message>
... commit message here ...
</commit_message>

Do NOT output anything outside these tags. No explanations, no markdown, no code fences.

Requirements:
1. Follow Conventional Commits.
2. Output a Title Line. If the change is complex, include a brief Body separated by a blank line. If simple, Title only.
3. English only.
4. type/scope are lowercase.
5. Types allowed: feat, fix, docs, style, refactor, test, chore
6. Title Summary under 72 characters.
7. Do NOT wrap with quotes/backticks.
8. Do NOT include any additional commentary outside the tags.
9. Do NOT include Co-authored-by or any other footer lines.

Generate the message based on the following git diff:
PROMPT
      echo
      echo "$DIFF"
    } | claude -p --model haiku
  )

  AI_COMMIT_MSG=$(
    echo "$RAW" \
    | awk '/<commit_message>/{flag=1; next} /<\/commit_message>/{flag=0} flag' \
    | sed -E 's/^[[:space:]`]*//;s/[[:space:]`]*$//'
  )

  if [ -z "${AI_COMMIT_MSG:-}" ]; then
    echo "Failed to generate commit message." >&2
    return 1
  fi

  echo "${AI_COMMIT_MSG}" > "${COMMIT_FILE}"

  echo ""
  echo "AI generated message loaded. Opening editor for review/edit..."
  git commit -e -F "${COMMIT_FILE}"

  echo "愛季「またねん👋🏻👋🏻」"
}

alias airi='gen-ai-commit-msg'

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
