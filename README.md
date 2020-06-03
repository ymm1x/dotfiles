# dotfiles

My dotfiles for OSX.

## install

```sh
git clone https://github.com/ymm1x/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
./deploy.sh
```

## update

```sh
git pull
./deploy.sh
```

## anyenv setup (optional)

```sh
anyenv install rbenv
rbenv install 2.3.3
rbenv global 2.3.3

anyenv install goenv
goenv install 1.11.1
goenv global 1.11.1

anyenv install pyenv
pyenv install 3.8.1
pyenv global 3.8.1

anyenv install nodenv
nodenv install 11.15.0
nodenv global 11.15.0
```
