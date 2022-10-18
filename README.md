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
asdf install ruby 2.5.9
asdf global ruby 2.5.9

# Go
# Python
# Node.js
```
