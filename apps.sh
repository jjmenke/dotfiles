#!/usr/bin/env bash

if ! which brew > /dev/null; then
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

echo "Updating and installing apps via Homebrew..."
# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install everything inside Brewfile
brew bundle

if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo "Switch to using brew-installed bash as default shell..."
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

if [ ! -d "$HOME/.rvm" ]; then
  echo "Installing RVM..."
  \curl -sSL https://get.rvm.io | bash -s stable
fi;

if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "Installing Plugged..."
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi;

# Remove outdated versions from the cellar.
brew cleanup