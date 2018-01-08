# Emacs 風キーバインド
bindkey -e
# 文字コードの設定
export LANG=ja_JP.UTF-8
# 履歴ファイルのパス
HISTFILE=~/.zsh_history
# メモリにのせる履歴上限
HISTSIZE=1000
# ファイルに保存する履歴上限
SAVEHIST=100000
# 履歴ファイルを上書きせず追加
setopt append_history
# すぐに履歴を追加
setopt inc_append_history
# 履歴の共有
setopt share_history
# 重複する履歴は古い方を削除
setopt hist_ignore_all_dups
# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups
# 先頭にSPACEを入れると履歴を残さない
setopt histignorespace
# 複数端末で履歴を共有
setopt sharehistory
# 補完候補に色を付ける
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:ex=01;32:*.tar=01;31'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 大文字小文字を無視して補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を ←↓↑→ で選択
zstyle ':completion:*:default' menu select true
# 補完キー連打で順に候補を選択
unsetopt automenu
# Shift-Tab で逆方向
bindkey "\e[Z" reverse-menu-complete
# aliases
alias dc='docker-compose'
alias gcop='git branch -a --sort=-authordate | cut -b 3- | perl -pe '\''s#^remotes/origin/###'\'' | perl -nlE '\''say if !$c{$_}++'\'' | grep -v -- "->" | peco | xargs git checkout'

: "for golang" && {
  if [ -x "`which go`" ]; then
    export GOPATH=$HOME/.go
    export PATH=$PATH:$GOPATH/bin
  fi
}

: "for ruby" && {
  if [ -x "`which rbenv`" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH" 
    eval "$(rbenv init - zsh)"
  fi
}

: "load zplug" && {
  # zplug
  source ~/.zplug/init.zsh
  zplug 'zplug/zplug', hook-build:'zplug --self-manage'
  # theme
  zplug "yous/lime"
  # highliting
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  # completions
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-history-substring-search"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  # git helper
  zplug "plugins/git", from:oh-my-zsh
  # install plugins
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  # source plugins and add commands to $PATH
  zplug load
}

: "enable autojump" && {
  if [[ -s `brew --prefix`/etc/autojump.sh ]] ; then
    . `brew --prefix`/etc/autojump.sh
  fi
}

: "enable peco history search" && {
  function peco-select-history() {
    local tac
    if which tac> /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history
}
