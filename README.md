# karanabe's dotfiles

Personal development environment for Debian/Ubuntu with Zsh, Neovim, uv, and
Volta.

## Setup

```shell
sudo apt-get update
sudo apt-get install -y git curl
mkdir -p "$HOME/project/code"
cd "$HOME/project/code"
git clone https://github.com/karanabe/dotfiles.git
cd dotfiles
./install.sh
./setup_zsh.sh
chsh -s /bin/zsh
exec zsh -l
```

The setup is idempotent for links already managed by this checkout. It refuses
to replace existing files, directories, or links pointing elsewhere. Move or
back up conflicting paths explicitly before retrying; in particular, never
discard an existing `.ssh` or `.gnupg` directory without inspecting it.

`unlink.sh` removes only links that point to this checkout. It does not remove
the files or directories behind those links.

## Toolchains

Python is managed by [uv](https://docs.astral.sh/uv/), Node.js by
[Volta](https://docs.volta.sh/guide/getting-started), and the editor is
[Neovim](https://neovim.io/).

```shell
program/python/install.sh
program/nodejs/install.sh
program/rust/install.sh
program/ruby/install.sh
program/golang/install.sh
```

The Python and Node.js installers do not modify shell startup files. Their
environment variables and executable paths are owned by `.common_export`, which
is linked as `~/.zshenv`.

Git identity remains machine-local. Create it once before signing commits:

```shell
cp .gitconfig.user.example "$HOME/.gitconfig.user"
nvim "$HOME/.gitconfig.user"
```

## Updates

```shell
./update.sh             # repository and Zsh plugins
./update.sh --system    # also upgrade system packages
program/python/update.sh
program/nodejs/update.sh
program/rust/update.sh
program/ruby/update.sh
```

## Validation

Run the non-destructive setup tests with:

```shell
bash tests/dotfiles_test.sh
```

Neovim and tmux key bindings are documented in [docs/keymap.md](docs/keymap.md).

## GPG keys

```shell
gpgen
gpedit <key-name>
gprip
gpexp >public.key
gpexpsec >secret.key
```

## License

Licensed under [The Unlicense](LICENSE).
