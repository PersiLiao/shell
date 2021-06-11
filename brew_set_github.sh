#!/bin/bash

# brew 程序本身，Homebrew / Linuxbrew 相同
git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git

# 以下针对 macOS 系统上的 Homebrew
BREW_TAPS="$(brew tap)"
for tap in core cask{,-fonts,-drivers,-versions}; do
	if echo "$BREW_TAPS" | grep -qE "^homebrew/${tap}\$"; then
		git -C "$(brew --repo homebrew/${tap})" remote set-url origin https://github.com/Homebrew/homebrew-${tap}.git
	fi
done

# 重新设置 git 仓库 HEAD
brew update-reset