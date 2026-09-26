# Homebrew is for formulae mise cannot replace and casks with a pkg installer.
# Command-line tools belong in mise/config.toml, other casks in mise.toml.

tap "jorgelbg/tap", trusted: true
tap "yukiarrr/tap", trusted: true

# Tied to macOS or linked by other software
brew "coreutils"
brew "docker-compose"
brew "docker-credential-helper"
brew "gnupg"
brew "libpq"
brew "mise"
brew "pinentry-mac"
brew "jorgelbg/tap/pinentry-touchid", trusted: true
brew "terminal-notifier"
brew "zsh-completions"

# Not in the mise registry
brew "aarch64-elf-gdb"
brew "lolcat"
brew "luv"
brew "tree"
brew "wget"
brew "yukiarrr/tap/ecsk", trusted: true
# The GitHub release nests the binary where mise's github backend cannot find it
brew "rubyfmt"

# pkg installers need sudo, which mise refuses
cask "google-japanese-ime"
cask "karabiner-elements"
cask "session-manager-plugin"
cask "twingate"
