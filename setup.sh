#!/usr/bin/env bash
# Installing and upgrading Mac OS X software applications and development tools/utilities.
# Rajesh Raheja
# July 2019

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
brew doctor && brew cask doctor && brew prune
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
  jupyter
)

brew install ${binaries[@]}

echo "Installing applications"
apps=(
  vagrant
  docker
  kitematic
  macvim
  vimr
  pycharm-ce
  intellij-idea-ce
  google-backup-and-sync
  cakebrew
  send-to-kindle
  keka
  keepingyouawake
  kindle
  xmind
)

brew cask install --appdir="/Applications" ${apps[@]}

echo "Cleaning up older packages and temporary files"
brew cleanup

# apm install ${atom_plugins[@]}

echo Setup complete on `date`.
exit 0
