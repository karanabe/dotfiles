#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
TEST_ROOT=$(mktemp -d)
trap 'rm -rf -- "$TEST_ROOT"' EXIT

fail() {
  printf 'not ok - %s\n' "$1" >&2
  exit 1
}

pass() {
  printf 'ok - %s\n' "$1"
}

create_fake_command() {
  local path=$1
  local label=$2
  mkdir -p -- "$(dirname -- "$path")"
  printf '%s\n' \
    '#!/usr/bin/env bash' \
    'set -u' \
    "printf '%s\\n' '$label' >>\"\$UPDATE_TEST_LOG\"" \
    "[[ \"\${UPDATE_FAIL_LABEL:-}\" != '$label' ]]" \
    >"$path"
  chmod 755 -- "$path"
}

create_fake_release_commands() {
  local fake_bin=$1
  mkdir -p -- "$fake_bin"

  printf '%s\n' \
    '#!/usr/bin/env bash' \
    'set -Eeuo pipefail' \
    'output=' \
    'url=' \
    'while (( $# > 0 )); do' \
    '  case "$1" in' \
    '    --output) output=$2; shift 2 ;;' \
    '    http://* | https://*) url=$1; shift ;;' \
    '    *) shift ;;' \
    '  esac' \
    'done' \
    'case "$url" in' \
    '  "https://go.dev/dl/?mode=json") source_file=$FAKE_GO_METADATA ;;' \
    '  https://go.dev/dl/*) source_file=$FAKE_GO_ARCHIVE ;;' \
    '  https://api.github.com/repos/neovim/neovim/releases/latest)' \
    '    source_file=$FAKE_NVIM_METADATA' \
    '    ;;' \
    '  https://github.com/neovim/neovim/releases/download/*)' \
    '    source_file=$FAKE_NVIM_ARCHIVE' \
    '    ;;' \
    '  *) printf "unexpected URL: %s\n" "$url" >&2; exit 1 ;;' \
    'esac' \
    'if [[ -n "$output" ]]; then' \
    '  cp -- "$source_file" "$output"' \
    'else' \
    '  cat -- "$source_file"' \
    'fi' \
    >"$fake_bin/curl"

  printf '%s\n' \
    '#!/usr/bin/env bash' \
    'case "${1:-}" in' \
    '  -s) printf "Linux\\n" ;;' \
    '  -m) printf "x86_64\\n" ;;' \
    '  *) /usr/bin/uname "$@" ;;' \
    'esac' \
    >"$fake_bin/uname"

  chmod 755 -- "$fake_bin/curl" "$fake_bin/uname"
}

create_release_fixtures() {
  local fixture_root=$1
  local go_version=go9.9.9
  local nvim_version=v9.9.9
  local go_archive="$fixture_root/$go_version.linux-amd64.tar.gz"
  local nvim_archive="$fixture_root/nvim-linux-x86_64.tar.gz"
  local go_checksum nvim_checksum

  mkdir -p -- \
    "$fixture_root/go-payload/go/bin" \
    "$fixture_root/nvim-payload/nvim-linux-x86_64/bin"
  printf '%s\n' \
    '#!/usr/bin/env bash' \
    "printf 'go version $go_version linux/amd64\\n'" \
    >"$fixture_root/go-payload/go/bin/go"
  printf '%s\n' \
    '#!/usr/bin/env bash' \
    "printf 'NVIM $nvim_version\\n'" \
    >"$fixture_root/nvim-payload/nvim-linux-x86_64/bin/nvim"
  chmod 755 -- \
    "$fixture_root/go-payload/go/bin/go" \
    "$fixture_root/nvim-payload/nvim-linux-x86_64/bin/nvim"

  tar -C "$fixture_root/go-payload" -czf "$go_archive" go
  tar -C "$fixture_root/nvim-payload" -czf "$nvim_archive" \
    nvim-linux-x86_64
  go_checksum=$(sha256sum "$go_archive" | awk '{print $1}')
  nvim_checksum=$(sha256sum "$nvim_archive" | awk '{print $1}')

  jq -n \
    --arg version "$go_version" \
    --arg checksum "$go_checksum" \
    '[{version: $version, stable: true, files: [{
      filename: ($version + ".linux-amd64.tar.gz"),
      os: "linux",
      arch: "amd64",
      version: $version,
      sha256: $checksum,
      kind: "archive"
    }]}]' >"$fixture_root/go.json"
  jq -n \
    --arg version "$nvim_version" \
    --arg checksum "$nvim_checksum" \
    '{tag_name: $version, assets: [{
      name: "nvim-linux-x86_64.tar.gz",
      browser_download_url: (
        "https://github.com/neovim/neovim/releases/download/" +
        $version + "/nvim-linux-x86_64.tar.gz"
      ),
      digest: ("sha256:" + $checksum)
    }]}' >"$fixture_root/nvim.json"
}

test_update_attempts_every_tool_after_failure() {
  local fixture="$TEST_ROOT/fixture"
  local home_directory="$TEST_ROOT/home"
  local fake_bin="$TEST_ROOT/bin"
  local update_log="$TEST_ROOT/updates.log"
  local output_file="$TEST_ROOT/output.log"
  local tool

  mkdir -p -- "$fixture"
  cp -- "$SCRIPT_DIR/../update.sh" "$fixture/update.sh"
  mkdir -p -- \
    "$fixture/.git" \
    "$home_directory/.local/share/zsh-syntax-highlighting/.git" \
    "$home_directory/.local/share/zsh-autosuggestions/.git" \
    "$fake_bin"

  for tool in python nodejs rust ruby golang neovim; do
    create_fake_command "$fixture/program/$tool/update.sh" "$tool"
  done
  printf '%s\n' '#!/usr/bin/env bash' 'exit 0' >"$fake_bin/git"
  chmod 755 -- "$fake_bin/git"

  export UPDATE_TEST_LOG="$update_log"
  export UPDATE_FAIL_LABEL=rust
  if HOME="$home_directory" PATH="$fake_bin:$PATH" \
    bash "$fixture/update.sh" >"$output_file" 2>&1; then
    fail 'the updater reports a component failure'
  fi

  local expected=$'python\nnodejs\nrust\nruby\ngolang\nneovim'
  local actual
  actual=$(<"$update_log")
  [[ "$actual" == "$expected" ]] \
    || fail 'all tool updaters run after a component failure'
  grep -q 'Failed updates:' "$output_file" \
    || fail 'the updater prints a failure summary'
  pass 'all tool updaters run and failures are summarized'
}

test_invalid_argument_is_rejected() {
  if bash "$SCRIPT_DIR/../update.sh" --invalid >/dev/null 2>&1; then
    fail 'invalid update arguments are rejected'
  fi
  pass 'invalid update arguments are rejected'
}

test_uv_update_reinstalls_without_receipt() {
  local fixture_root="$TEST_ROOT/uv"
  local fake_bin="$fixture_root/bin"
  local home_directory="$fixture_root/home"
  local fake_installer="$fixture_root/uv-install.sh"

  mkdir -p -- "$fake_bin" "$home_directory"
  printf '%s\n' \
    '#!/bin/sh' \
    'set -eu' \
    'test "${UV_NO_MODIFY_PATH:-}" = 1' \
    'mkdir -p -- "$HOME/.local/bin"' \
    'printf "updated\n" >"$HOME/.local/bin/uv"' \
    >"$fake_installer"
  printf '%s\n' \
    '#!/usr/bin/env bash' \
    'set -Eeuo pipefail' \
    'output=' \
    'url=' \
    'while (( $# > 0 )); do' \
    '  case "$1" in' \
    '    --output) output=$2; shift 2 ;;' \
    '    http://* | https://*) url=$1; shift ;;' \
    '    *) shift ;;' \
    '  esac' \
    'done' \
    '[[ "$url" == "https://astral.sh/uv/install.sh" ]]' \
    'cp -- "$FAKE_UV_INSTALLER" "$output"' \
    >"$fake_bin/curl"
  printf '%s\n' \
    '#!/usr/bin/env bash' \
    'exit 2' \
    >"$fake_bin/uv"
  chmod 755 -- "$fake_bin/curl" "$fake_bin/uv"

  FAKE_UV_INSTALLER="$fake_installer" \
    HOME="$home_directory" PATH="$fake_bin:$PATH" \
    bash "$SCRIPT_DIR/../program/python/update.sh" >/dev/null

  [[ "$(<"$home_directory/.local/bin/uv")" == updated ]] \
    || fail 'uv is reinstalled when no self-update receipt exists'
  pass 'uv update works without a self-update receipt'
}

test_uv_update_prefers_self_update() {
  local fixture_root="$TEST_ROOT/uv-self-update"
  local fake_bin="$fixture_root/bin"
  local home_directory="$fixture_root/home"
  local update_log="$fixture_root/update.log"

  mkdir -p -- "$fake_bin" "$home_directory"
  printf '%s\n' \
    '#!/usr/bin/env bash' \
    'printf "%s|%s|%s\n" "${UV_NO_MODIFY_PATH:-}" "$1" "$2" >"$UV_UPDATE_LOG"' \
    >"$fake_bin/uv"
  printf '%s\n' \
    '#!/usr/bin/env bash' \
    'printf "standalone installer should not run\n" >&2' \
    'exit 1' \
    >"$fake_bin/curl"
  chmod 755 -- "$fake_bin/curl" "$fake_bin/uv"

  UV_UPDATE_LOG="$update_log" \
    HOME="$home_directory" PATH="$fake_bin:$PATH" \
    bash "$SCRIPT_DIR/../program/python/update.sh" >/dev/null

  [[ "$(<"$update_log")" == '1|self|update' ]] \
    || fail 'uv self update is preferred for supported installations'
  pass 'uv self update is preferred when available'
}

test_release_installers_verify_and_activate_archives() {
  local fixture_root="$TEST_ROOT/releases"
  local fake_bin="$TEST_ROOT/release-bin"
  local home_directory="$TEST_ROOT/release-home"

  mkdir -p -- "$fixture_root" "$home_directory"
  create_fake_release_commands "$fake_bin"
  create_release_fixtures "$fixture_root"

  export FAKE_GO_METADATA="$fixture_root/go.json"
  export FAKE_GO_ARCHIVE="$fixture_root/go9.9.9.linux-amd64.tar.gz"
  export FAKE_NVIM_METADATA="$fixture_root/nvim.json"
  export FAKE_NVIM_ARCHIVE="$fixture_root/nvim-linux-x86_64.tar.gz"

  HOME="$home_directory" PATH="$fake_bin:$PATH" \
    bash "$SCRIPT_DIR/../program/golang/install.sh" >/dev/null
  HOME="$home_directory" PATH="$fake_bin:$PATH" \
    bash "$SCRIPT_DIR/../program/neovim/install.sh" >/dev/null

  [[ "$("$home_directory/.local/lang/go/bin/go" version)" \
    == 'go version go9.9.9 linux/amd64' ]] \
    || fail 'the verified Go archive is activated'
  [[ -L "$home_directory/.local/opt/nvim/currVer" ]] \
    || fail 'the verified Neovim archive is activated'
  [[ "$("$home_directory/.local/opt/nvim/currVer/bin/nvim" --version)" \
    == 'NVIM v9.9.9' ]] \
    || fail 'the active Neovim link runs the verified release'
  pass 'release installers verify and activate archives'
}

test_release_installer_rejects_bad_checksum() {
  local fixture_root="$TEST_ROOT/bad-release"
  local fake_bin="$TEST_ROOT/bad-release-bin"
  local home_directory="$TEST_ROOT/bad-release-home"

  mkdir -p -- "$fixture_root" "$home_directory"
  create_fake_release_commands "$fake_bin"
  create_release_fixtures "$fixture_root"
  printf 'corrupt\n' >>"$fixture_root/nvim-linux-x86_64.tar.gz"

  export FAKE_GO_METADATA="$fixture_root/go.json"
  export FAKE_GO_ARCHIVE="$fixture_root/go9.9.9.linux-amd64.tar.gz"
  export FAKE_NVIM_METADATA="$fixture_root/nvim.json"
  export FAKE_NVIM_ARCHIVE="$fixture_root/nvim-linux-x86_64.tar.gz"

  if HOME="$home_directory" PATH="$fake_bin:$PATH" \
    bash "$SCRIPT_DIR/../program/neovim/install.sh" >/dev/null 2>&1; then
    fail 'a Neovim archive with a bad checksum is rejected'
  fi
  [[ ! -e "$home_directory/.local/opt/nvim/currVer" ]] \
    || fail 'an unverified Neovim release is not activated'
  pass 'release installers reject invalid checksums'
}

test_update_attempts_every_tool_after_failure
test_invalid_argument_is_rejected
test_uv_update_reinstalls_without_receipt
test_uv_update_prefers_self_update
test_release_installers_verify_and_activate_archives
test_release_installer_rejects_bad_checksum
