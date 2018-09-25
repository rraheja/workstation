#!/usr/bin/env bash
# Installing and upgrading Mac OS X software applications and development tools/utilities.
# Rajesh Raheja
# September 2018

# Install Apple X-code command line tools
echo "Installing X Code command line tools. Accept the agreement on the opened window. Ignore error if already installed."
xcode-select --install

# Install brew if not installed
echo "Installing brew if not installed"
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Uninstall using \'ruby -e \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)\"\'"
else
  echo HomeBrew already installed in `brew --prefix`
fi

echo "Running brew config..."
brew config
echo "Running brew doctor..."
brew doctor && brew cask doctor
echo "In case of permission errors, run 'sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local'"
echo "Listing installed binaries and applications"
brew list && brew cask list
echo "Listing outdated binaries and applications"
brew outdated
echo "Upgrading brew and installed software"
brew update && brew upgrade && brew cleanup

# Install software
echo "Installing binaries"
binaries=(
  openssl
  wget
  git
  bash-completion
  vim
  node
  python
)

brew install ${binaries[@]}

echo "Installing applications"
apps=(
# Programming - Docker and Virtualbox require password hence prioritizing 
  docker
  virtualbox
  vagrant
  iterm2
  macvim
  vimr
  atom
  github-desktop
  pycharm-ce
# Productivity
  cakebrew
  send-anywhere
  send-to-kindle
  keka
  filezilla
  franz
  keepingyouawake
  kindle
  adobe-acrobat-reader
  google-backup-and-sync
  google-nik-collection
  camtasia
  cisco-proximity
  copyclip
  vlc
  xmind
  wordpresscom
  zoomus
  zoomus-outlook-plugin
)

brew cask install --appdir="/Applications" ${apps[@]}

echo "Cleaning up older packages and temporary files"
brew cleanup

echo "Installing atom plugins"
atom_plugins=(
  atom-beautify
  color-picker
  git-history
  merge-conflicts 
  vim-mode
)

apm install ${atom_plugins[@]}

echo Setup complete on `date`.
exit 0
