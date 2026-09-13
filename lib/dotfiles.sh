#!/usr/bin/env bash

# Shared helpers for the dotfiles entry-point scripts. This file is sourced,
# so callers are responsible for enabling their preferred shell options.

dotfiles_error() {
  printf '[dotfiles] %s\n' "$*" >&2
}

dotfiles_require_safe_home() {
  if [[ -z "${HOME:-}" || "$HOME" == "/" ]]; then
    dotfiles_error 'HOME must point to a user directory.'
    return 1
  fi
}

dotfiles_require_commands() {
  local -a missing_commands=()
  local command_name

  for command_name in "$@"; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
      missing_commands+=("$command_name")
    fi
  done

  if (( ${#missing_commands[@]} > 0 )); then
    dotfiles_error "Required commands are missing: ${missing_commands[*]}"
    return 1
  fi
}

dotfiles_prepare_home() {
  dotfiles_require_safe_home || return

  local -a directories=(
    "$HOME/.cache"
    "$HOME/.config"
    "$HOME/.local/bin"
    "$HOME/.local/etc"
    "$HOME/.local/lang"
    "$HOME/.local/opt"
    "$HOME/.local/share"
    "$HOME/.local/usr"
    "$HOME/.local/var"
    "$HOME/.visualarts/.gnupg"
    "$HOME/.visualarts/.ssh"
    "$HOME/downloads"
    "$HOME/project/data"
    "$HOME/project/docs"
    "$HOME/tmp"
  )
  local -a private_directories=(
    "$HOME/.local"
    "$HOME/.visualarts"
    "$HOME/.visualarts/.gnupg"
    "$HOME/.visualarts/.ssh"
    "$HOME/downloads"
    "$HOME/project"
    "$HOME/tmp"
  )

  mkdir -p -- "${directories[@]}"
  chmod 700 -- "${private_directories[@]}"
}

dotfiles_validate_link_pair() {
  local source_path=$1
  local target_path=$2

  if [[ ! -e "$source_path" ]]; then
    dotfiles_error "Link source does not exist: $source_path"
    return 1
  fi

  if [[ -L "$target_path" ]]; then
    if [[ "$target_path" -ef "$source_path" ]]; then
      return 0
    fi
    dotfiles_error "Refusing to replace a link managed elsewhere: $target_path"
    return 1
  fi

  if [[ -e "$target_path" ]]; then
    dotfiles_error "Refusing to replace an existing file or directory: $target_path"
    return 1
  fi
}

dotfiles_link_paths() {
  if (( $# == 0 || $# % 2 != 0 )); then
    dotfiles_error 'Link paths must be supplied as source/target pairs.'
    return 2
  fi

  local -a paths=("$@")
  local index source_path target_path

  # Validate every destination before creating anything, avoiding partial setup.
  for ((index = 0; index < ${#paths[@]}; index += 2)); do
    dotfiles_validate_link_pair "${paths[index]}" "${paths[index + 1]}" || return
  done

  for ((index = 0; index < ${#paths[@]}; index += 2)); do
    source_path=${paths[index]}
    target_path=${paths[index + 1]}
    if [[ -L "$target_path" ]]; then
      printf '[dotfiles] Already linked: %s\n' "$target_path"
      continue
    fi
    mkdir -p -- "$(dirname -- "$target_path")"
    ln -s -- "$source_path" "$target_path"
    printf '[dotfiles] Linked: %s -> %s\n' "$target_path" "$source_path"
  done
}

dotfiles_unlink_paths() {
  if (( $# == 0 || $# % 2 != 0 )); then
    dotfiles_error 'Unlink paths must be supplied as source/target pairs.'
    return 2
  fi

  local -a paths=("$@")
  local index source_path target_path
  local status=0

  for ((index = 0; index < ${#paths[@]}; index += 2)); do
    source_path=${paths[index]}
    target_path=${paths[index + 1]}
    if [[ -L "$target_path" && "$target_path" -ef "$source_path" ]]; then
      rm -- "$target_path"
      printf '[dotfiles] Unlinked: %s\n' "$target_path"
    elif [[ -e "$target_path" || -L "$target_path" ]]; then
      dotfiles_error "Skipped path not managed by this repository: $target_path"
      status=1
    fi
  done

  return "$status"
}

dotfiles_zsh_paths() {
  local action=$1
  local repo_root=$2

  "$action" \
    "$repo_root/.zshrc" "$HOME/.zshrc" \
    "$repo_root/.zsh_profile" "$HOME/.zprofile" \
    "$repo_root/.common_alias" "$HOME/.zshalias" \
    "$repo_root/.common_export" "$HOME/.zshenv" \
    "$repo_root/.gitconfig" "$HOME/.gitconfig" \
    "$repo_root/.gitmessage" "$HOME/.gitmessage" \
    "$repo_root/.tmux.conf" "$HOME/.tmux.conf" \
    "$repo_root/tools/nvim" "$HOME/.config/nvim" \
    "$HOME/.visualarts/.gnupg" "$HOME/.gnupg" \
    "$HOME/.visualarts/.ssh" "$HOME/.ssh"
}

dotfiles_record_repo() {
  local repo_root=$1
  dotfiles_require_safe_home || return

  local record_file="$HOME/.local/.dotfiles"
  local temporary_file
  mkdir -p -- "$HOME/.local"
  temporary_file=$(mktemp "$HOME/.local/.dotfiles.XXXXXX")
  if ! printf '%s\n' "$repo_root" >"$temporary_file"; then
    rm -f -- "$temporary_file"
    return 1
  fi
  chmod 600 -- "$temporary_file"
  mv -Tf -- "$temporary_file" "$record_file"
}

dotfiles_clone_or_update() {
  local repository_url=$1
  local destination=$2

  if [[ -d "$destination/.git" ]]; then
    git -C "$destination" pull --ff-only
  elif [[ -e "$destination" ]]; then
    dotfiles_error "Refusing to replace non-repository path: $destination"
    return 1
  else
    mkdir -p -- "$(dirname -- "$destination")"
    git clone --depth 1 -- "$repository_url" "$destination"
  fi
}
