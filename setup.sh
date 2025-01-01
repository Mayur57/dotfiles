#!/usr/bin/env bash

# Exit immediately at script failure point
set -euo pipefail

ERROR_LOG="setup_error.log"
exec 2>>${ERROR_LOG}
trap 'log_message "${COLOR_RED}" "An error occurred. Check ${ERROR_LOG} for details." && exit 1' ERR

COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_BLUE="\033[34m"
COLOR_MAGENTA="\033[35m"
COLOR_NORMAL="\033[0;39m"

log_message() {
    local color="$1"
    local message="$2"
    printf "\n${color}${message}${COLOR_NORMAL}\n"
}

execute_command() {
    local command="$1"
    log_message "${COLOR_MAGENTA}" "Executing: ${command}"
    eval "${command}"
}

SYSTEM_ARCH=$(uname -m)
log_message "${COLOR_BLUE}" "Detected system architecture: ${SYSTEM_ARCH}"

if ! ping -c 1 google.com &>/dev/null; then
    log_message "${COLOR_RED}" "No internet connection detected. Please check your network."
    exit 1
fi

log_message "${COLOR_GREEN}" "Checking for existing installations..."
if ! command -v brew &>/dev/null; then
    log_message "${COLOR_MAGENTA}" "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    log_message "${COLOR_YELLOW}" "Homebrew is already installed, skipping..."
fi

log_message "${COLOR_GREEN}" "Installing essential Homebrew packages..."
BREW_PACKAGES=(yarn gh jq wget tree)
for package in "${BREW_PACKAGES[@]}"; do
    if ! brew list "${package}" &>/dev/null; then
        execute_command "brew install ${package}"
    else
        log_message "${COLOR_YELLOW}" "${package} is already installed, skipping..."
    fi
done

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_message "${COLOR_MAGENTA}" "Installing Oh My Zsh..."
    execute_command "sh -c '$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)'"
else
    log_message "${COLOR_YELLOW}" "Oh My Zsh is already installed, skipping..."
fi

ZSHRC_FILE="$HOME/.zshrc"
if [[ -f ${ZSHRC_FILE} ]]; then
    log_message "${COLOR_YELLOW}" "Backing up existing ${ZSHRC_FILE} to ${ZSHRC_FILE}.bak"
    cp "${ZSHRC_FILE}" "${ZSHRC_FILE}.bak"
fi
execute_command "cp ./.zshrc ~/.zshrc"

log_message "${COLOR_GREEN}" "Installing Node Version Manager (NVM) and Node.js..."
if [[ ! -d "$HOME/.nvm" ]]; then
    execute_command "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash"
    source ~/.zshrc
fi
execute_command "nvm install --lts"

if [[ ${SYSTEM_ARCH} == "arm64" ]]; then
    log_message "${COLOR_YELLOW}" "Configuring for Apple Silicon (arm64) mac..."
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    log_message "${COLOR_YELLOW}" "Configuring for Intel (x86 64 bit) mac..."
fi

log_message "${COLOR_GREEN}" "Downloading and setting up applications..."
mkdir -p ~/Desktop/Applications

postman_url=$([[ "${SYSTEM_ARCH}" == "arm64" ]] && echo "https://dl.pstmn.io/download/latest/osx_arm64" || echo "https://dl.pstmn.io/download/latest/osx_64")
notion_url=$([[ "${SYSTEM_ARCH}" == "arm64" ]] && echo "https://www.notion.so/desktop/apple-silicon/download" || echo "https://www.notion.so/desktop/mac/download")
vscode_url=$([[ "${SYSTEM_ARCH}" == "arm64" ]] && echo "https://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64" || echo "https://code.visualstudio.com/sha/download?build=stable&os=darwin")

declare -A APPLICATIONS_URLS=(
    ["Rectangle"]="https://github.com/rxhanson/Rectangle/releases/download/v0.61/Rectangle0.61.dmg"
    ["iTerm2"]="https://iterm2.com/downloads/stable/latest"
    ["Postman"]="${postman_url}"
    ["Notion"]="${notion_url}"
    ["Visual Studio Code"]="${vscode_url}"
    ["Spotify"]="https://download.scdn.co/SpotifyInstaller.zip"
    ["Rocket"]="https://macrelease.matthewpalmer.net/Rocket.dmg"
)

for app in "${!APPLICATIONS_URLS[@]}"; do
    log_message "${COLOR_MAGENTA}" "Downloading ${app}..."
    curl -L# "${APPLICATIONS_URLS[$app]}" -o "$HOME/Desktop/Applications/${app}"
done

log_message "${COLOR_GREEN}" "Installing VS Code extensions..."
cd vscode && bash extensions.sh

log_message "${COLOR_GREEN}" "Configuring git..."
git config --global user.name "Mayur Bhoi"
git config --global user.email "mayur072000@gmail.com"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"

log_message "${COLOR_GREEN}" "Installing fonts..."
FONT_DIR="$HOME/Library/Fonts"
mkdir -p "${FONT_DIR}"
cp fonts/**/*.{otf,ttf} "${FONT_DIR}"

log_message "${COLOR_GREEN}" "All set. These are the next steps:"
log_message "${COLOR_GREEN}" "1. Install extensions for VS Code by running: cd vscode && bash extensions.sh"
log_message "${COLOR_GREEN}" "2. Install applications downloaded from ~/Desktop/apps folder"
log_message "${COLOR_GREEN}" "3. For Advent of Code stuff to work, add {export AOC_SESSION_TOKEN=<token>} to your ~/.zshrc file"
