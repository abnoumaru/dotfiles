## Initial Setup

1. `xcode-select --install`
2. Install Homebrew from https://brew.sh, then `brew install mise`
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

Prefer mise. Use the Brewfile only when mise cannot.

| What | Where | How |
|------|-------|-----|
| Command-line tool or runtime | `mise/config.toml` | `mise use -g <tool>` |
| App bundle cask | `mise.toml` `[bootstrap.packages]` | `mise bootstrap packages use brew-cask:<cask>` |
| pkg installer cask | `Brewfile` | Add a `cask` line, then `mise run brew` |
| Formula not in the mise registry | `Brewfile` | Add a `brew` line, then `mise run brew` |
| Config file | `mise.toml` `[dotfiles]` | Add an entry, then `mise bootstrap --only dotfiles` |
| macOS setting | `mise.toml` `[bootstrap.macos.defaults]` | Match the type from `defaults read-type` |

## Syncing

```bash
git pull && mise bootstrap   # apply changes from another Mac
mise bootstrap status        # show drift
```

```bash
mise upgrade                     # tools
mise bootstrap packages upgrade  # casks mise installed
brew upgrade                     # Brewfile, and casks Homebrew installed
```

Deleting an entry does not uninstall or unlink anything:

| Removed from | Clean up with |
|--------------|---------------|
| `mise/config.toml` | `mise uninstall --all <tool>` |
| `[bootstrap.packages]` | `brew uninstall --cask <cask>` |
| `Brewfile` | `brew uninstall <name>` |
| `[dotfiles]` | `mise bootstrap dotfiles unapply` |
| `[bootstrap.macos.defaults]` | Reset it in System Settings |

Do not run `mise bootstrap packages prune` while the Brewfile lists formulae. It
removes every Homebrew formula not in `[bootstrap.packages]`, mise included.

## Directory Structure

| Directory | Description |
|-----------|-------------|
| `claude/` | Claude Code configuration |
| `ghostty/` | Terminal emulator |
| `git/` | Git configuration template |
| `karabiner/` | Keyboard remapping |
| `mise/` | Tool version management |
| `neovim/` | Editor configuration |
| `postgres/` | psqlrc configuration |
| `starship/` | Shell prompt |
| `zed/` | Zed editor configuration |
| `zsh/` | Shell configuration |
