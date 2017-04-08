# dotfiles

## Starting from scratch

Set your preferences

```sh
DOTFILES_PATH='$HOME/.dotfiles'
GITUSER=bboykov
GITREPO=dotfiles
ALIAS_LOCATION='$HOME/.bashrc'
```

Configure dotfiles repo and alias

```sh
git init --bare $DOTFILES_PATH
alias dotfiles="/usr/bin/git --git-dir=$DOTFILES_PATH --work-tree=\$HOME"
dotfiles remote add origin git@github.com:$GITUSER/$GITREPO.git

dotfiles config --local status.showUntrackedFiles no
echo "alias dotfiles='/usr/bin/git --git-dir=$DOTFILES_PATH  --work-tree=\$HOME'" >> $ALIAS_LOCATION
```

## Setup new host

```sh
git clone --separate-git-dir=$DOTFILES_PATH https://github.com/$GITUSER/$GITREPO.git dotfiles-tmp

rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
```

## Usage

```sh
dotfiles status
dotfiles add .gitconfig
dotfiles commit -m 'Add gitconfig'
dotfiles push
```

# References

[The best way to store your dotfiles: A bare Git repository][dotfiles-article1]

[dotfiles-article1]: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

