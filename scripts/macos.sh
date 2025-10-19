#!/bin/sh

set -ex

# Finderで隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -bool true

# Dockを自動的に隠す
defaults write com.apple.dock autohide -bool true

# キーボードのリピート速度を最速に設定する
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# スクリーンショットの保存先を変更する
if [ ! -d "${HOME}/Pictures/screenshots" ]; then
    mkdir -p "${HOME}/Pictures/screenshots"
fi
defaults write com.apple.screencapture location "${HOME}/Pictures/screenshots"

# ref: https://github.com/ianyh/Amethyst/blob/development/README.md?plain=1#L33
defaults write com.apple.dock workspaces-auto-swoosh -bool NO

# スクリプトを実行した後に変更を反映させる
killall Finder
killall Dock
