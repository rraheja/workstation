#!/usr/bin/env bash
# Installing new mac software
# Rajesh Raheja
# October 2015

# Install Apple X-code command line tools
echo "Installing X Code command line tools. Accept the agreement on the opened window."
xcode-select --install

# Install brew if not installed
echo "Installing brew if not installed"
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update && brew install caskroom/cask/brew-cask
  echo "Uninstall using 'ruby -e \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)\"'"
fi
   
echo "Checking brew"
brew config
brew doctor && brew cask doctor
echo "In case of permission errors, run 'sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local'"
echo "Listing installed binaries and applications"
brew list && brew cask list
echo "Listing outdated binaries and applications"
brew outdated
echo "Upgrading installed software"
brew update && brew upgrade && brew cleanup && brew cask cleanup

# Install software
echo "Installing binaries"
binaries=(
  openssl
  wget
  git
  bash-completion
  node
  python
  go
  pandoc
  packer
  terraform
)

brew install ${binaries[@]}

echo "Installing applications"
apps=(
# Dev tools
  cakebrew
  iterm2
  macvim
  vimr
  sublime-text3
  atom
  github
  sourcetree
  virtualbox
  vagrant
  otto
  nomad
  keka
  cyberduck
# Productivity tools
  dropbox
  google-chrome
  firefox
  slack
  skype
  kindle
  send-to-kindle
  caffeine
  remote-desktop-connection
  pdf-toolbox
  kodi
  mplayerx
)

brew cask install --appdir="/Applications" ${apps[@]}

echo "Cleaning up older packages and temporary files"
brew cleanup && brew cask cleanup

echo "Installing atom plugins"
atom_plugins=(
  atom-beautify
  color-picker
  git-history
  markdown-preview 
  merge-conflicts 
  vim-mode
)

apm install ${atom_plugins[@]}

echo Setup complete on `date`.
exit 0

