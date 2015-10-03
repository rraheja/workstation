#!/usr/bin/env bash
# Installing and upgrading Mac OS X software applications and development tools/utilities.
# Rajesh Raheja
# October 2015

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
  go
  packer
  terraform
  pandoc
  markdown
  corkscrew
)

brew install ${binaries[@]}

echo "Installing applications"
apps=(
# Dev tools
# Virtualbox and Docker require password to be entered hence prioritizing first
  virtualbox
  dockertoolbox
  cakebrew
  iterm2
  macvim
  vimr
  sublime-text
  atom
  otto
  nomad
  vagrant
  github-desktop
  sourcetree
  keka
  cyberduck
# Productivity tools
  dropbox
  google-chrome
  firefox
  evernote
  crashplan
  caffeine
  slack
  skype
  kindle
  mplayerx
)

brew cask install --appdir="/Applications" ${apps[@]}

echo "Cleaning up older packages and temporary files"
brew cleanup && brew cask cleanup

echo "Setting up CrashPlan for headless server operations"
echo "Stopping locally installed CrashPlan server. This may require administrator password."
sudo launchctl unload -w /Library/LaunchDaemons/com.crashplan.engine.plist
ps auxww | grep -i CrashPlanService
echo "Ensure CrashPlan is not running above."
echo "Changing CrashPlan UI to point to NAS server."
sudo sed -i inplace 's/#serviceHost=127.0.0.1/serviceHost=192.168.1.12/' /Applications/CrashPlan.app/Contents/Resources/Java/conf/ui.properties
echo "Changing CrashPlan Menu Helper App to point to NAS server."
sudo sed -i inplace 's/127.0.0.1/192.168.1.12/' /Applications/CrashPlan.app/Contents/Helpers/CrashPlan\ menu\ bar.app/Contents/Info.plist
echo "Updating UI key to allow connection to NAS server. Login to the NAS and perform 'cat /var/lib/crashplan/.ui_info' to get the value."
sudo rm -f /Library/Application\ Support/CrashPlan/.ui_info
sudo cp ~/Documents/Dropbox/.ssh/crashplan.ui_info /Library/Application\ Support/CrashPlan/.ui_info
sudo chmod 644 /Library/Application\ Support/CrashPlan/.ui_info

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
