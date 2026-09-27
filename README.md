## Initial Setup

1. `xcode-select --install`
2. `curl https://mise.run | sh`
3. Clone. The symlinks point into this path, so do not move it later.

   ```bash
   git clone https://github.com/abnoumaru/dotfiles ~/go/src/github.com/abnoumaru/dotfiles
   cd ~/go/src/github.com/abnoumaru/dotfiles
   mise trust
   ```

4. Move aside any existing file the dry run reports as a conflict, then apply.

   ```bash
   mise bootstrap --dry-run
   mise bootstrap
   ```

5. `mise run gitconfig` and `gh auth login`
6. Log out and back in, and grant Karabiner-Elements its permissions.

## Adding something

| What | Where | How |
|------|-------|-----|
| Command-line tool or runtime | `mise/global.toml` | `mise use -g <tool>` |
| Cask | `mise.toml` `[bootstrap.packages]` | `mise bootstrap packages use brew-cask:<cask>` |
| Formula | `mise.toml` `[bootstrap.packages]` | `mise bootstrap packages use brew:<formula>` |
| Config file | `mise.toml` `[dotfiles]` | Add an entry, then `mise bootstrap --only dotfiles` |
| macOS setting | `mise.toml` `[bootstrap.macos.defaults]` | Match the type from `defaults read-type` |

## Syncing

```bash
git pull && mise bootstrap   # apply changes from another Mac
mise bootstrap status        # show drift
```

```bash
mise self-update                 # mise
mise upgrade                     # tools
mise bootstrap packages upgrade  # formulae, and casks mise installed
brew upgrade --cask              # casks Homebrew installed
```

Deleting an entry does not uninstall or unlink anything:

| Removed from | Clean up with |
|--------------|---------------|
| `mise/global.toml` | `mise uninstall --all <tool>` |
| `[bootstrap.packages]` | `mise bootstrap packages prune`, or `brew uninstall --cask <cask>` if Homebrew installed it |
| `[dotfiles]` | `mise bootstrap dotfiles unapply` |
| `[bootstrap.macos.defaults]` | Reset it in System Settings |

## Directory Structure

| Directory | Description |
|-----------|-------------|
| `claude/` | Claude Code configuration |
| `ghostty/` | Terminal emulator |
| `git/` | Git configuration template |
| `karabiner/` | Keyboard remapping |
| `mise/` | Tool version management |
| `nvim/` | Editor configuration |
| `postgres/` | psqlrc configuration |
| `starship/` | Shell prompt |
| `zed/` | Zed editor configuration |
| `zsh/` | Shell configuration |
