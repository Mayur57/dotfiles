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

colorize() {
    printf "\n${MAGENTA}$1${NORMAL}\n"
}

# printf "${GREEN}
# ┌───────────────────────────────────────────┐
# │                                           │
# │            macOS Device Setup             │
# │                                           │
# └───────────────────────────────────────────┘
# ${NORMAL}"

# printf "${BLUE}\n─────────────────────────────────────────────"
# printf "\n─→ PART ONE: System Preferences\n"
# printf "─────────────────────────────────────────────${NORMAL}\n"

# # Show hidden dotfiles in finder
# printf "\n${MAGENTA}Showing hidden files to be visible finder${NORMAL}\n"
# printf "${WHITE}Note: This will reload Finder.${NORMAL}\n"
# # eval "defaults write com.apple.finder AppleShowAllFiles YES"
# # eval "killall Finder"

# printf "\n${MAGENTA}Enabling auto-hide Dock${NORMAL}\n"
# # eval "defaults write com.apple.dock autohide -bool true && killall Dock"

# printf "\n${MAGENTA}Enabling system dark mode${NORMAL}\n"
# # osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'

# printf "${BLUE}\n─────────────────────────────────────────────"
# printf "\n─→ PART TWO: Development Tools\n"
# printf "─────────────────────────────────────────────${NORMAL}\n"

# # Install XCode Command Line Tools
# printf "\n${MAGENTA}Installing Xcode Command Line Tools${NORMAL}\n"
# # eval "xcode-select --install"

# # Install Homebrew for easier macOS package management
# printf "\n${MAGENTA}Installing Homebrew${NORMAL}\n"
# # eval '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

# # If this is an M1 mac
# if [[ `uname -m` == 'arm64' ]]; then
#   echo 'eval "${YELLOW}This Mac device is an Apple Silicon device.${NORMAL}"'
#   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$USER/.zprofile"
#   eval "$(/opt/homebrew/bin/brew shellenv)"
# fi

# # Install Yarn for easier (and faster) Node.js dependency management
# printf "\n${MAGENTA}Installing Yarn${NORMAL}\n"
# # eval "brew install yarn --ignore-dependencies"

# # Install Oh My Zsh
# printf "\n${MAGENTA}Installing Oh My Zsh${NORMAL}\n"
# # eval "sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'"

# # Copy ZSH config
# printf "\n${MAGENTA}Copying ZSH config into ~/.zshrc${NORMAL}\n"
# # eval "cp ./.zshrc ~/.zshrc"

# # Install NVM
# printf "\n${MAGENTA}Installing Node Version Manager (nvm)${NORMAL}\n"
# # eval "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash"
# # eval "source ~/.zshrc"
# # eval "nvm install --lts"

# # Install brew casks
# printf "\n${MAGENTA}Installing other brew casks${NORMAL}\n"
# # eval "brew install gh"

# # All the applications that cannot be installed using Homebrew casks.
# printf "${BLUE}\n─────────────────────────────────────────────"
# printf "\n─→ PART THREE: Applications\n"
# printf "─────────────────────────────────────────────${NORMAL}\n"
# printf "\n${WHITE}Note: All the images and archives will be available in Desktop/Applications${NORMAL}\n"
# # eval "mkdir ~/Desktop/Applications"

#  # Window Management
# colorize "Downloading Rectangle"
# curl -L# https://github.com/rxhanson/Rectangle/releases/download/v0.61/Rectangle0.61.dmg > ~/Desktop/Applications/Rectangle.dmg

# # Terminal app
# colorize "Downloading iTerm2"
# curl -L# https://iterm2.com/downloads/stable/latest > ~/Desktop/Applications/iTerm2.zip

# # Postman
# colorize "Downloading Postman Desktop"
# if [[ `uname -m` == 'arm64' ]]; then
#   echo "${YELLOW}\nThis Mac device is an Apple Silicon device.\n${NORMAL}"
#   curl -L# https://dl.pstmn.io/download/latest/osx_arm64 > ~/Desktop/Applications/Postman-arm64.zip # For Apple Silicon
# fi
# curl -L# https://dl.pstmn.io/download/latest/osx_64 > ~/Desktop/Applications/Postman.zip # For x64

# # Replace Spotlight Search
# colorize "Downloading Raycast"
# curl -L# https://www.raycast.com/download > ~/Desktop/Applications/Raycast.zip

# # Note taking and more
# colorize "Downloading Notion"
# if [[ `uname -m` == 'arm64' ]]; then
#   echo "${YELLOW}\nThis Mac device is an Apple Silicon device.\n${NORMAL}"
#   curl -L# https://www.notion.so/desktop/apple-silicon/download > ~/Desktop/Applications/Notion-arm64.dmg # For Apple Silicon
# fi
# curl -L# https://www.notion.so/desktop/mac/download > ~/Desktop/Applications/Notion.dmg # x86

# # Brave Browser
# colorize "Downloading Brave"
# curl -L# https://laptop-updates.brave.com/latest/osx > ~/Desktop/Applications/Brave.dmg

# # Replace Media Player
# colorize "Downloading IINA Player"
# curl -L# https://dl-portal.iina.io/IINA.v1.3.0.dmg > ~/Desktop/Applications/IINA.dmg

# # Whatsapp Desktop
# colorize "Downloading Whatsapp Desktop"
# curl -L# https://web.whatsapp.com/desktop/mac/files/WhatsApp.dmg > ~/Desktop/Applications/WhatsApp.dmg

# # Zoom Desktop
# colorize "Downloading Zoom Desktop"
# curl -L# https://zoom.us/client/latest/Zoom.pkg > ~/Desktop/Applications/Zoom.pkg

# # Visual Studio Code
# colorize "Downloading Notion"
# if [[ `uname -m` == 'arm64' ]]; then
#   echo "${YELLOW}\nThis Mac device is an Apple Silicon device.\n${NORMAL}"
#   curl -L# https://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64 > ~/Desktop/Applications/VSCode-arm64.dmg # For Apple Silicon
# fi
# curl -L# https://code.visualstudio.com/sha/download?build=stable&os=darwin > ~/Desktop/Applications/VSCode.dmg # x86

# colorize "Setting up VS Code extensions"
# eval "sh ./vscode/extensions.sh"

# # Spotify
# colorize "Downloading Spotify"
# curl -L# https://download.scdn.co/SpotifyInstaller.zip > ~/Desktop/Applications/Spotify.zip

# # SpotMenu
# colorize "Downloading SpotMenu"
# curl -L# https://github.com/kmikiy/SpotMenu/releases/download/v1.8/SpotMenu.zip > ~/Desktop/Applications/SpotMenu.zip

# # Figma Desktop
# colorize "Downloading Figma Desktop"
# curl -#L https://www.figma.com/download/desktop/mac > ~/Desktop/Applications/Figma.zip

# # Rocket Emoji Input
# colorize "Downloading Rocket Emoji Input"
# curl -L# https://macrelease.matthewpalmer.net/Rocket.dmg > ~/Desktop/Applications/Rocket.dmg

printf "${BLUE}\n─────────────────────────────────────────────"
printf "\n─→ PART FOUR: Fonts\n"
printf "─────────────────────────────────────────────${NORMAL}\n"

colorize "Installing fonts"
cp fonts/**/*.{otf,ttf} ~/Library/Fonts/

printf "${GREEN}
┌───────────────────────────────────────────┐
│                                           │
│             Setup successful!             │
│              You're all set               │
│                                           │
└───────────────────────────────────────────┘
${NORMAL}"
