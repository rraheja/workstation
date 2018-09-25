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
  echo "Uninstall using 'ruby -e \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)\"'"
else
  echo HomeBrew already installed in `brew --prefix`
fi

echo "Updating brew and installing Cask"
brew update && brew install caskroom/cask/brew-cask

echo "Checking brew"
brew config
brew doctor && brew cask doctor
echo "In case of permission errors, run 'sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local'"
echo "Listing installed binaries and applications"
brew list && brew cask list
echo "Listing outdated binaries and applications"
brew outdated
echo "Upgrading installed software"
brew upgrade && brew cleanup && brew cask cleanup

# Install software
echo "Installing binaries"
binaries=(
  openssl
  wget
  git
  bash-completion
  node
  python
#  pandoc
#  markdown
#  corkscrew
)

brew install ${binaries[@]}

echo "Installing applications"
apps=(
# Dev tools
# Virtualbox and Docker require password to be entered hence prioritizing first
#  virtualbox
#  dockertoolbox
  cakebrew
  iterm2
  macvim
  vimr
  vim
  atom
  github-desktop
  keka
  filezilla
  google-chrome
  google-drive
  keepingyouawake
  kindle
)

brew cask install --appdir="/Applications" ${apps[@]}

echo "Cleaning up older packages and temporary files"
brew cleanup && brew cask cleanup

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
