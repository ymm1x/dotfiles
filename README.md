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

## asdf setup (optional)

```sh
# Ruby
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 3.4.5
asdf global ruby 3.4.5

# Go
asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf install golang 1.20.12
asdf global golang 1.20.12

# Python
# Node.js
```
