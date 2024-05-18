# .dotfiles

forever changing

## get the repo

It doesn’t matter what the local name is, but it does need to be in the `$HOME` directory to work with later `stow` commands.

```sh
git clone https://github.com/sineraves/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## install packages (mac)

### install homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### install homebrew packages

The `brew bundle` command will self-install on first run, and then install the contents of `Brewfile`.

```sh
cd ~/.dotfiles
brew bundle
```

## install dot files / package configs

[stow](https://www.gnu.org/software/stow/manual/) is a "symlink farm manager". It creates symlinks to relevant config files in this repo from the parent directory.

```sh
cd ~/.dotfiles
stow --dotfiles .
```

The `--dotfiles` flag tells stow to treat names beginning with `dot-` as `.`. stow creates the symlink:

```sh
.zshrc -> .dotfiles/dot-zshrc
```

Without this flag, we’d need a file named `.zshrc` in the repo, which would be hidden due to the leading `.`.

### when `stow` can’t be found

On first run on a mac, we probably can’t find Homebrew installed executables like `stow`. When this happens, try running:

```sh
cd ~/.dotfiles
/opt/homebrew/bin/stow --dotfiles .
```
