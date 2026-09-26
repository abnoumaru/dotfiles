# dotfiles

macOS dotfiles repository set up by [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html).
`mise.toml` declares the dotfile symlinks and macOS defaults; the Brewfile and
`mise/config.toml` hold the packages and tools.

## Prerequisites

1. Install Command Line Tools: `xcode-select --install`
2. Install Homebrew: https://brew.sh
3. Install mise: `curl https://mise.run | sh`

## Quick Start

```bash
mise bootstrap --dry-run   # preview
mise bootstrap             # dotfiles, macOS defaults, tools, then brew bundle
mise run gitconfig         # interactive, run once per machine
```

## Checking drift

```bash
mise bootstrap status
```

- Removals need hands: a dotfile dropped from `[dotfiles]` stays linked
  (`mise bootstrap dotfiles unapply`), and a dropped macOS default keeps its value.
- An existing `~/.config/karabiner` directory is moved aside to
  `~/.config/karabiner.bak.<timestamp>` before linking.

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

## References

- https://zenn.dev/botamotch/articles/e7960f0dc84d8b
- https://gist.github.com/sheepla/d680f1480d8c36c4290d6aabebf1abc6
- https://zenn.dev/monica/articles/81c8f632b72584
- https://zenn.dev/nokogiri/articles/ec99e40df54555
