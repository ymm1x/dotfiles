#!/bin/bash
set -euo pipefail

source lib/echos.sh

function command_exists() {
  type "$1" &> /dev/null ;
}

: "install brew" && {
  if ! command_exists brew; then
    info "installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "${HOME}/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    warn "brew is already installed"
  fi
}

: "install qlmarkdown" && {
  package="qlmarkdown"
  if ! brew list | grep "$package" &> /dev/null; then
    info "installing ${package}..."
    brew install "${package}"
    xattr -r -d com.apple.quarantine "/Applications/QLMarkdown.app"
  else
    warn "${package} is already installed"
  fi
}

: "install sleepwatcher" && {
  package="sleepwatcher"
  if ! brew list | grep "$package" &> /dev/null; then
    info "installing ${package}..."
    brew install "${package}"
    brew services start "${package}"
  else
    warn "${package} is already installed"
  fi
}

: "install other packages by brew" && {
  packages=( peco ghq jq tree wget autojump direnv colordiff \
    coreutils diffutils findutils asdf )
  for package in ${packages[@]}; do
    if ! brew list | grep "$package" &> /dev/null; then
      info "installing ${package}..."
      brew install "${package}"
    else
      warn "${package} is already installed"
    fi
  done
}

: "install zplug" && {
  ZPLUG_DIR=$HOME/.zplug
  if [ ! -e $ZPLUG_DIR ]; then
    info "installing zplug..."
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  else
    warn "zplug is already installed"
  fi
}

ok "Complete!"
