#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=../../lib/dotfiles.sh
source "$SCRIPT_DIR/../../lib/dotfiles.sh"

install_neovim() (
  set -Eeuo pipefail

  dotfiles_require_safe_home
  dotfiles_require_commands curl jq sha256sum tar uname

  if [[ "$(uname -s)" != "Linux" ]]; then
    dotfiles_error 'The Neovim installer currently supports Linux only.'
    return 1
  fi

  local architecture
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

  local archive_name="nvim-linux-$architecture.tar.gz"
  local extracted_name="nvim-linux-$architecture"
  local install_root="$HOME/.local/opt/nvim"
  local releases_root="$install_root/releases"
  local current_link="$install_root/currVer"
  mkdir -p -- "$releases_root"
  if [[ -e "$current_link" && ! -L "$current_link" ]]; then
    dotfiles_error "Refusing to replace non-link path: $current_link"
    return 1
  fi

  local release_metadata release_asset version asset_url asset_digest checksum
  release_metadata=$(curl --fail --location --show-error --silent \
    --proto '=https' --proto-redir '=https' --tlsv1.2 \
    --header 'Accept: application/vnd.github+json' \
    --header 'X-GitHub-Api-Version: 2022-11-28' \
    --user-agent 'karanabe-dotfiles' \
    https://api.github.com/repos/neovim/neovim/releases/latest)
  version=$(jq -er '.tag_name' <<<"$release_metadata")
  if ! release_asset=$(jq -cer --arg archive_name "$archive_name" \
    '[.assets[] | select(.name == $archive_name)][0] // empty' \
    <<<"$release_metadata"); then
    dotfiles_error "The latest Neovim release has no asset named $archive_name."
    return 1
  fi
  asset_url=$(jq -er '.browser_download_url' <<<"$release_asset")
  asset_digest=$(jq -er '.digest' <<<"$release_asset")
  checksum=${asset_digest#sha256:}

  if [[ ! "$version" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] \
    || [[ "$asset_url" != https://github.com/neovim/neovim/releases/download/*/"$archive_name" ]] \
    || [[ "$asset_digest" != sha256:* ]] \
    || [[ ! "$checksum" =~ ^[[:xdigit:]]{64}$ ]]; then
    dotfiles_error 'Neovim release metadata returned an invalid asset.'
    return 1
  fi

  local release_dir="$releases_root/$version-$architecture"

  if [[ -L "$release_dir" ]]; then
    dotfiles_error "Refusing to use a linked Neovim release: $release_dir"
    return 1
  elif [[ -d "$release_dir" ]]; then
    if [[ ! -x "$release_dir/bin/nvim" ]] \
      || [[ "$("$release_dir/bin/nvim" --version \
        | sed -n '1s/^NVIM //p')" != "$version" ]]; then
      dotfiles_error "Existing Neovim release is invalid: $release_dir"
      return 1
    fi
  elif [[ -e "$release_dir" ]]; then
    dotfiles_error "Refusing to replace existing Neovim path: $release_dir"
    return 1
  else
    local temporary_dir archive_path downloaded_version
    temporary_dir=$(mktemp -d "$install_root/.install.XXXXXX")
    trap 'rm -rf -- "$temporary_dir"' EXIT
    archive_path="$temporary_dir/$archive_name"

    curl --fail --location --show-error --silent \
      --proto '=https' --proto-redir '=https' --tlsv1.2 \
      "$asset_url" --output "$archive_path"
    if ! printf '%s  %s\n' "$checksum" "$archive_path" \
      | sha256sum --check --status; then
      dotfiles_error "Neovim checksum verification failed: $archive_name"
      return 1
    fi
    tar -xzf "$archive_path" -C "$temporary_dir"
    downloaded_version=$("$temporary_dir/$extracted_name/bin/nvim" --version \
      | sed -n '1s/^NVIM //p')
    if [[ "$downloaded_version" != "$version" ]]; then
      dotfiles_error \
        "Downloaded Neovim version mismatch: expected $version, got $downloaded_version"
      return 1
    fi
    mv -- "$temporary_dir/$extracted_name" "$release_dir"
  fi

  local temporary_link="$install_root/.currVer.$$"
  ln -s -- "$release_dir" "$temporary_link"
  if ! mv -Tf -- "$temporary_link" "$current_link"; then
    rm -f -- "$temporary_link"
    return 1
  fi
  printf '[dotfiles] Neovim %s is active.\n' "$version"
)

install_neovim
