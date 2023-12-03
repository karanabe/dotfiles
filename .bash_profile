# Load bashrc
test -r $HOME/.bashrc && . $HOME/.bashrc

# Load the shell dotfiles
for file in ~/.{bash_alias,bash_export,bash_prompt}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file" &>/dev/null
done
unset file
