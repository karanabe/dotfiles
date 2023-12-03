#!/bin/bash

## rbenv setup
rm -rf $HOME/.local/lang/rbenv
git clone https://github.com/rbenv/rbenv.git $HOME/.local/lang/rbenv
cd $HOME/.local/lang/rbenv && src/configure && make -C src

### As an rbenv plugin
mkdir -p $HOME/.local/lang/rbenv/plugins
git clone https://github.com/rbenv/ruby-build.git $HOME/.local/lang/rbenv/plugins/ruby-build

# Its need for 3.2.0 higher
sudo apt install libyaml-dev

