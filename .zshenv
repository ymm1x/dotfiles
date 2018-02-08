# language
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# editor
export EDITOR=vim
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=100000

# pushd
DIRSTACKSIZE=15

# ls command colors
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# for anyenv
export PATH="$HOME/.anyenv/bin:$PATH"

# for npm
if which npm> /dev/null; then
  export PATH="`npm bin -g`:$PATH"
fi

# for golang
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

: "load local .zshenv setting if exists" && {
  if [ -f ~/.zshenv.local ]; then
      source ~/.zshenv.local
  fi
}
