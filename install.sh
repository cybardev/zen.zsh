#!/bin/sh
# Install script for Zen Zsh prompt
echo Installing Zen...
[ ! -d "$HOME/.zsh" ] && mkdir -p "$HOME/.zsh"
cp -r "./zen" "$HOME/.zsh/"
echo Installation complete.
echo Add the following to your .zshrc file:
echo ""
echo 'fpath=("$HOME/.zsh/zen" $fpath)'
echo autoload -Uz promptinit
echo promptinit
echo prompt zen
