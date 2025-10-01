#!/bin/bash

shell_name=$(basename "$SHELL")

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

    case "$(basename "$shell_path")" in
      bash)
        modify_config "$HOME/.bashrc"
        ;;
      zsh)
        if [[ "$OSTYPE" == "darwin"* ]]; then
          sed -i '' -e 's/zsh-autosuggestions//g' ~/.zshrc
        else
          sed -i -e 's/zsh-autosuggestions//g' ~/.zshrc
        fi

        modify_config "$HOME/.zshrc"
        ;;
      *)
        ;;
    esac
  done < /etc/shells
else
  /bin/echo "Error: File not found: /etc/shells. Alas :("
fi
