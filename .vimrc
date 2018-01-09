"文字コードをUFT-8に設定
set fenc=utf-8
" 行番号表示
set number
" 最後のカーソル位置を復元
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
" 画面最後の行をできる限り表示
set display=lastline
" シンタックスハイライトを有効にする
set term=xterm-256color
syntax on
