#!/bin/bash

# Exit immediately at script failure point
set -euo pipefail

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
WHITE="\033[37m"
NORMAL="\033[0;39m"

printf "\n${GREEN}┌───────────────────────────────────────────┐
│                                           │
│            macOS Device Setup             │
│                                           │
└───────────────────────────────────────────┘${NORMAL}\n"

printf "${BLUE}\n─────────────────────────────────────────────"
printf "\n─→ PART ONE: System Preferences\n"
printf "─────────────────────────────────────────────${NORMAL}\n"

# Show hidden dotfiles in finder
printf "\n${MAGENTA}Showing hidden files to be visible finder${NORMAL}\n"
printf "${WHITE}Note: This will reload Finder.${NORMAL}\n"
# eval "defaults write com.apple.finder AppleShowAllFiles YES"
# eval "killall Finder"

printf "\n${MAGENTA}Enabling auto-hide Dock${NORMAL}\n"
# eval "defaults write com.apple.dock autohide -bool true && killall Dock"

printf "${BLUE}\n─────────────────────────────────────────────"
printf "\n─→ PART TWO: Development Tools\n"
printf "─────────────────────────────────────────────${NORMAL}\n"

# Install XCode Command Line Tools
printf "\n${MAGENTA}Installing Xcode Command Line Tools${NORMAL}\n"
# eval "xcode-select --install"

# Install Homebrew for easier macOS package management
printf "\n${MAGENTA}Installing Homebrew${NORMAL}\n"
# eval '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

# If this is an M1 mac
if [[ `uname -m` == 'arm64' ]]; then
  echo 'eval "${YELLOW}This Mac device is an Apple Silicon device.${NORMAL}"'
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$USER/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install Yarn for easier (and faster) Node.js dependency management
printf "\n${MAGENTA}Installing Yarn for Node package management${NORMAL}\n"
# eval "brew install yarn --ignore-dependencies"

# Install Oh My Zsh
printf "\n${MAGENTA}Installing Oh My zsh${NORMAL}\n"
# eval "sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'"

# Copy ZSH config
# printf "${YELLOW}Copying ZSH config into ~/.zshrc...${NORMAL}\n"
# eval "cp ./zshrc ~/.zshrc"

# Install NVM
printf "\n${MAGENTA}Installing Node Version Manager (nvm)${NORMAL}\n"
# eval "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash"
# eval "source ~/.zshrc"
# eval "nvm install --lts"

# Install brew casks
printf "\n${MAGENTA}Installing other brew casks${NORMAL}\n"
# eval "brew install gh"

# All the applications that cannot be installed using Homebrew casks.
printf "${BLUE}\n─────────────────────────────────────────────"
printf "\n─→ PART THREE: Applications\n"
printf "─────────────────────────────────────────────${NORMAL}\n"
printf "\n${WHITE}Note: All the DMG files will be available in Desktop/Applications${NORMAL}\n"
eval "mkdir ~/Desktop/Applications"
eval "eval '\nDownloading Rectangle\n' | curl -L# https://github.com/rxhanson/Rectangle/releases/download/v0.61/Rectangle0.61.dmg > ~/Desktop/Applications/Rectangle.dmg" # Window Management
eval "eval '\nDownloading iTerm2\n' | curl -L# https://iterm2.com/downloads/stable/latest > ~/Desktop/Applications/iTerm2.zip" # Terminal app
if [[ `uname -m` == 'arm64' ]]; then
  echo "${YELLOW}\nThis Mac device is an Apple Silicon device.\n${NORMAL}"
  eval "\nDownloading Postman Desktop for Apple Silicon\n | curl -L# https://dl.pstmn.io/download/latest/osx_arm64 > ~/Desktop/Applications/Postman-arm64.zip" # Postman for Apple Silicon
fi
eval "\nDownloading Postman Desktop for Apple Silicon\n | curl -L# https://dl.pstmn.io/download/latest/osx_64 > ~/Desktop/Applications/Postman.zip" # Postman for Apple Silicon

