#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck source=../../lib/dotfiles.sh
source "$SCRIPT_DIR/../../lib/dotfiles.sh"

install_go() (
  set -Eeuo pipefail

  dotfiles_require_safe_home
  dotfiles_require_commands awk curl jq sha256sum tar uname

  if [[ "$(uname -s)" != "Linux" ]]; then
    dotfiles_error 'The Go installer currently supports Linux only.'
    return 1
  fi

  local architecture
  case "$(uname -m)" in
    x86_64)
      architecture=amd64
      ;;
    aarch64 | arm64)
      architecture=arm64
      ;;
    *)
      dotfiles_error "Unsupported Go architecture: $(uname -m)"
      return 1
      ;;
  esac

  local metadata_url='https://go.dev/dl/?mode=json'
  if [[ -n "${GO_PACKAGE:-}" ]]; then
    metadata_url+='&include=all'
  fi

  local release_metadata release_file
  release_metadata=$(curl --fail --location --show-error --silent \
    --proto '=https' --proto-redir '=https' --tlsv1.2 \
    "$metadata_url")
  if [[ -n "${GO_PACKAGE:-}" ]]; then
    if ! release_file=$(jq -cer --arg filename "$GO_PACKAGE" \
      '[.[].files[] | select(.filename == $filename)][0] // empty' \
      <<<"$release_metadata"); then
      dotfiles_error "Official Go metadata does not contain: $GO_PACKAGE"
      return 1
    fi
  elif ! release_file=$(jq -cer --arg architecture "$architecture" \
    '[.[0].files[] | select(.os == "linux" and .arch == $architecture and .kind == "archive")][0] // empty' \
    <<<"$release_metadata"); then
    dotfiles_error "Could not find the latest Linux/$architecture Go archive."
    return 1
  fi

  local archive_name version checksum
  archive_name=$(jq -er '.filename' <<<"$release_file")
  version=$(jq -er '.version' <<<"$release_file")
  checksum=$(jq -er '.sha256' <<<"$release_file")
  if [[ ! "$version" =~ ^go[0-9]+\.[0-9]+(\.[0-9]+)?([a-z]+[0-9]+)?$ ]] \
    || [[ "$archive_name" != "${version}.linux-${architecture}.tar.gz" ]] \
    || [[ ! "$checksum" =~ ^[[:xdigit:]]{64}$ ]]; then
    dotfiles_error 'Go release metadata returned an invalid archive or checksum.'
    return 1
  fi

  local install_root="$HOME/.local/lang"
  local install_directory="$install_root/go"
  if [[ -x "$install_directory/bin/go" ]] \
    && [[ "$("$install_directory/bin/go" version | awk '{print $3}')" == "$version" ]]; then
    printf '[dotfiles] Go %s is already active.\n' "$version"
    return
  fi

  local temporary_dir archive_path
  mkdir -p -- "$install_root"
  temporary_dir=$(mktemp -d "$install_root/.go-install.XXXXXX")
  trap 'rm -rf -- "$temporary_dir"' EXIT
  archive_path="$temporary_dir/$archive_name"

  curl --fail --location --show-error --silent \
    --proto '=https' --proto-redir '=https' --tlsv1.2 \
    "https://go.dev/dl/$archive_name" \
    --output "$archive_path"
  if ! printf '%s  %s\n' "$checksum" "$archive_path" \
    | sha256sum --check --status; then
    dotfiles_error "Go checksum verification failed: $archive_name"
    return 1
  fi
  tar -C "$temporary_dir" -xzf "$archive_path"

  local installed_version
  installed_version=$("$temporary_dir/go/bin/go" version | awk '{print $3}')
  if [[ "$installed_version" != "$version" ]]; then
    dotfiles_error \
      "Downloaded Go version mismatch: expected $version, got $installed_version"
    return 1
  fi

  local backup_directory="$install_root/.go.previous.$$"
  if [[ -e "$backup_directory" || -L "$backup_directory" ]]; then
    dotfiles_error "Refusing to replace existing backup path: $backup_directory"
    return 1
  fi

  if [[ -e "$install_directory" || -L "$install_directory" ]]; then
    mv -- "$install_directory" "$backup_directory"
  fi
  if ! mv -- "$temporary_dir/go" "$install_directory"; then
    [[ ! -e "$backup_directory" && ! -L "$backup_directory" ]] \
      || mv -- "$backup_directory" "$install_directory"
    return 1
  fi
  [[ ! -e "$backup_directory" && ! -L "$backup_directory" ]] \
    || rm -rf -- "$backup_directory"

  printf '[dotfiles] Go %s is active.\n' "$version"
)

install_go
