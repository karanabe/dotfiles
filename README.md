# karanabe's dotfiles


## How to setup

```shell
$ sudo apt update && sudo apt -y upgrade
$ sudo apt install git curl
$ mkdir -p $HOME/project/code
$ sudo chmod 700 project
$ cd $HOME/project/code
$ git clone https://github.com/karanabe/dotfiles.git
$ cd dotfiles
$ ./unlink.sh
$ ./setup_zsh.sh
$ ./install.sh
$ # ./install_dev.sh
```


## Change login shell

`chsh -s /bin/zsh`


## ssh-keygen

ssh-keygen -t ed25519 -C "email or name"


## Update editor

`sudo update-alternatives --config editor`


## install program languages

```bash
program/nodenv/install.sh
program/ruby/install.sh
program/rust/install.sh
program/python/install.sh
```


### python

```bash
pyenv install --list
pyenv install 3.12.0
source ~/.zprofile
mkdir -p $HOME/.local/usr/pydev
cd $HOME/.local/usr/pydev
python -m venv dev
```


### nodenv

```bash
nodenv install 20.10.0
nodenv global 20.10.0
npm install -g pnpm
```

### ruby

```bash
rbenv install 3.2.2
rbenv global 3.2.2

# https://pages.github.com/versions/
rbenv install 2.7.4
```


## gpg key

```bash
# create ECC and Curve 25519
gpgen
gpedit <key_name>

# add subkey for sign
addkey

# check key file name
gprip

# export
gpexp > public.key
gpexpsec > secret.key

# delete
gprm <keygrip_name>
```


### License

<sup>
Licensed under <a href="LICENSE">The Unlicense</a>.
</sup>

