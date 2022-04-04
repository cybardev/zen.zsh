#!/bin/sh

# Install script for Zen Zsh prompt
echo Installing Zen...
[ ! -d "$HOME/.zsh" ] && mkdir -p "$HOME/.zsh"
if [ ! -d "$HOME/.zsh/zen" ]; then
    cp -r "./zen" "$HOME/.zsh/"
else
    echo "$HOME/.zsh/zen already exists."
    echo Zen prompt was not installed.
    exit 1
fi
echo Installation complete.
echo Add the following to your .zshrc file:
echo ""
echo 'fpath+="$HOME/.zsh/zen"'
echo autoload -Uz promptinit
echo promptinit
echo prompt zen
