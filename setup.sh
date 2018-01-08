#!/bin/bash
set -euo pipefail

source lib/echos.sh

readonly DOT_FILES=( .vimrc .bashrc )

for file in ${DOT_FILES[@]}; do
  dest=${HOME}/${file}
  if [ -e ${dest} ]; then
    warn "[warn] ${dest}: skipped (already exists)"
  else
    ln -s $HOME/dotfiles/$file $dest
    ok "[ ok ] ${dest}: created"
  fi
done

ok "All installed!"
