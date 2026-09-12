#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=lib/dotfiles.sh
source "$SCRIPT_DIR/lib/dotfiles.sh"

install_system_packages() {
  sudo apt-get update
  sudo apt-get install -y \
    curl \
    git \
    gnupg \
    iproute2 \
    lsof \
    psmisc \
    rsync \
    ssh \
    strace \
    tmux \
    wget \
    xz-utils \
    zsh
}

install_neovim() (
  set -Eeuo pipefail

  local architecture archive_name extracted_name
  case "$(uname -m)" in
    x86_64)
      architecture=x86_64
      ;;
    aarch64 | arm64)
      architecture=arm64
      ;;
    *)
      dotfiles_error "Unsupported Neovim architecture: $(uname -m)"
      return 1
      ;;
  esac

  archive_name="nvim-linux-$architecture.tar.gz"
  extracted_name="nvim-linux-$architecture"

  local install_root="$HOME/.local/opt/nvim"
  local releases_root="$install_root/releases"
  local temporary_dir
  temporary_dir="$(mktemp -d "$install_root/.install.XXXXXX")"
  trap 'rm -rf -- "$temporary_dir"' EXIT

  curl --fail --location --show-error --silent \
    "https://github.com/neovim/neovim/releases/latest/download/$archive_name" \
    --output "$temporary_dir/$archive_name"
  tar -xzf "$temporary_dir/$archive_name" -C "$temporary_dir"

  local version release_dir current_link temporary_link
  version=$("$temporary_dir/$extracted_name/bin/nvim" --version | sed -n '1s/^NVIM //p')
  if [[ -z "$version" ]]; then
    dotfiles_error 'Could not determine the downloaded Neovim version.'
    return 1
  fi

  release_dir="$releases_root/$version-$architecture"
  mkdir -p -- "$releases_root"
  if [[ ! -d "$release_dir" ]]; then
    mv -- "$temporary_dir/$extracted_name" "$release_dir"
  fi

  current_link="$install_root/currVer"
  if [[ -e "$current_link" && ! -L "$current_link" ]]; then
    dotfiles_error "Refusing to replace non-link path: $current_link"
    return 1
  fi
  temporary_link="$install_root/.currVer.$$"
  ln -s -- "$release_dir" "$temporary_link"
  mv -Tf -- "$temporary_link" "$current_link"
  printf '[dotfiles] Neovim %s is active.\n' "$version"
)

dotfiles_prepare_home

if [[ -z "${IS_DOCKER:-}" ]]; then
  install_system_packages
fi

install_neovim
dotfiles_clone_or_update \
  https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$HOME/.local/share/zsh-syntax-highlighting"
dotfiles_clone_or_update \
  https://github.com/zsh-users/zsh-autosuggestions.git \
  "$HOME/.local/share/zsh-autosuggestions"
dotfiles_record_repo "$SCRIPT_DIR"

printf '[dotfiles] Installation complete.\n'
