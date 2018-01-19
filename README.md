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
goenv install 1.9.2
goenv global 1.9.2

anyenv install pyenv
pyenv install 2.7.13
pyenv global 2.7.13

anyenv install nodenv
nodenv install 6.10.3
nodenv global 6.10.3
```

