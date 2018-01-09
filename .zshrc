: "bindkey settings" && {
  # Emacs 風キーバインド
  bindkey -e
  # Shift-Tab で逆方向
  bindkey "\e[Z" reverse-menu-complete
  # Ctrl-U の挙動を bash に合わせる
  bindkey \^U backward-kill-line
  # Delete
  bindkey "^[[3~" delete-char  
}

: "history settings" && {
  # 履歴ファイルを上書きせず追加
  setopt append_history
  # すぐに履歴を記録
  setopt inc_append_history
  # 履歴の共有
  setopt share_history
  # 重複する履歴は古い方を削除
  setopt hist_ignore_all_dups
  # 直前と同じコマンドラインはヒストリに記録しない
  setopt hist_ignore_dups
  # 先頭にSPACEを入れると履歴を記録しない
  setopt histignorespace
  # 余分なスペースを取り除いてヒストリに記録する
  setopt hist_reduce_blanks
  # 複数端末で履歴を共有
  setopt sharehistory
  # `!*` を実行したときすぐに実行しない
  setopt hist_verify
}

: "completion settings" && {
  # 補完候補に色を付ける
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  # 大文字小文字を無視して補完 (ただし入力された case type を優先する)
  zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
  # 補完候補を ←↓↑→ で選択
  zstyle ':completion:*:default' menu select true
  # 補完キー連打で順に候補を選択
  unsetopt automenu
}

: "common aliases" && {
  alias dc='docker-compose'
  alias history='fc -l 1'
  alias vs='code'
}

: "declare helper functions" && {
  # ブランチ切り替え補助
  # ref. https://qiita.com/ymm1x/items/a735e82244a877ac4d23
  function gcop() {
    git branch -a --sort=-authordate | cut -b 3- | perl -pe 's#^remotes/origin/###' | perl -nlE 'say if !$c{$_}++' | grep -v -- "->" | peco --query="$*" | xargs git checkout
  }
}

: "enable rbenv" && {
  if [ -x "`which rbenv`" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH" 
    eval "$(rbenv init - zsh)"
  fi
}

: "enable zplug" && {
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

: "enable direnv" && {
  eval "$(direnv hook zsh)"
}

: "load local .zshrc if exists" && {
  if [ -f ~/.zshrc.local ]; then
      source ~/.zshrc.local
  fi
}
