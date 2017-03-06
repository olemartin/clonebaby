#!/bin/sh

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew.."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update

echo "Installing packages.."

# Install other useful binaries
packages=(
  ansible
  bash
  coreutils
  git
  gnupg2
  go
  hub
  macvim
  node
  openssl
  pass
  python
  terminal-notifier
  terraform
  vim
  wget
  yarn
  z
)

# Install the packages
brew install ${packages[@]}

apps=(
  atom
  dropbox
  firefox
  flux
  google-chrome
  google-drive
  intellij-idea
  iterm2
  java
  jce-unlimited-strength-policy
  qlmarkdown
  qlcolorcode
  quicklook-json
  qlmarkdown
  qlstephen
  slack
  spotify
  vlc
)

# Maven depends on the cask-installed java
brew install maven

echo "Installing apps.."
brew cask install ${apps[@]}

echo "Installing fonts ..."
brew tap caskroom/fonts
brew cask install font-hack
brew cask install font-fira-code

echo "Setting up dotfiles"
if [ ! -d ~/.vim ]; then
  git clone https://github.com/fredva/dotvim.git ~/.vim
fi

echo "Cloning dotvim"
if [ ! -d ~/.dotfiles ]; then
  git clone https://github.com/fredva/dotfiles.git ~/.dotfiles
  ~/.dotfiles/setup.sh
fi

echo "Settings.."
defaults write com.apple.systemsound 'com.apple.sound.uiaudio.enabled' -int 0
defaults write -g InitialKeyRepeat -int 20
defaults write -g KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

exit 0

