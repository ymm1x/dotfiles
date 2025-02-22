function command_exists() {
  type "$1" &> /dev/null ;
}

: "enable brew" && {
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

: "enable asdf" && {
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
}

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
  # cd のときに自動で pushd する
  setopt auto_pushd
  # コマンドライン実行時にもコメント (#) を有効にする
  setopt interactivecomments

  # Workaround: https://qiita.com/entertvl/items/1cf56c8b02515377adda
  # history の保存先
  HISTFILE=~/.zsh_history
  # メモリに保持する履歴の最大件数
  HISTSIZE=10000
  # ファイルに保持する履歴の最大件数
  SAVEHIST=100000
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

: "declare helper functions" && {
  # ブランチ切り替え補助
  # ref. https://qiita.com/ymm1x/items/a735e82244a877ac4d23
  function gcop() {
    git branch -a --sort=-authordate |
      grep -v -e '->' -e '*' |
      perl -pe 's/^\h+//g' |
      perl -pe 's#^remotes/origin/##' |
      perl -nle 'print if !$c{$_}++' |
      peco --initial-filter Regexp --query="$*" |
      xargs git checkout
  }
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
  # shell's history search
  zplug "zsh-users/zsh-history-substring-search"

  # install plugins
  if [ ! ~/.zplug/last_zshrc_check_time -nt ~/.zshrc ]; then
    touch ~/.zplug/last_zshrc_check_time
    if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
        echo; zplug install
      fi
    fi
  fi

  # assign key of zsh-history-substring-searchassign
  if zplug check "zsh-users/zsh-history-substring-search"; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
  fi

  # source plugins and add commands to $PATH
  zplug load
}

: "common aliases" && {
  alias dc='docker-compose'
  alias vs='code'
  # history を全件表示
  alias history='fc -l 1'
  # ls をカラー表示
  alias ls='ls -G'
  # シェルの設定を再読み込み
  alias reload='exec $SHELL -l'
  # diff をカラー表示
  if command_exists colordiff; then
    alias diff='colordiff'
  fi
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
    BUFFER=$(\history -n 1 | eval $tac | peco --initial-filter Regexp --query "$LBUFFER")
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

: "overwrite lime prompt" && {
  render_prompt() {
    LIME_DIR_COLOR=110
    LIME_GIT_COLOR=248
    echo -n "%(?.$(tput setaf 110).$(tput setaf 124))[]$(tput sgr0)"
    echo -n ' '
    prompt_lime_dir
    echo -n ' '
    prompt_lime_git
    echo -n "$(tput setaf 246)"
    echo -n "@$(date '+%H:%M')"
    echo
    echo -n "${prompt_lime_rendered_symbol}"
  }
  PROMPT='$(render_prompt) '
}

