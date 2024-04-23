# Overview

Nothing to see here, just attempting to keep my dotfiles in sync between systems. 

## Guide

If you're curious how my dotfiles project works, here's how I set it up: 

1. **Init a [bare git repository][1]**. 
   
   ```
   $ git init --bare $HOME/.dotfiles 
   ```

2. **Create a `dotfiles` alias for managing your config files**. Since `git`  
   expects a `.git` directory to know when a folder is being tracked, the 
   normal `git` commands won't work for your dotfiles. 
   
   ```
   $ git status
   fatal: Not a git repository (or any of the parent directories): .git
   ```
   
   So let's create an alias called `dotfiles`:
   
   ```
   $ alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
   ```
   
   NOTE: You'll probably want to add your `dotfiles` alias to your aliases 
   file. I'm old school and like using BASH, so I add mine to `.bash_aliases`,
   if you're using a different shell you might need to put it elsewhere.
   
   ```
   $ echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'" >> $HOME/.bash_aliases
   ```

3. **Disable untracked files**. This is important, otherwise git will warn 
   us about every file in our `$HOME` directory! Ain't nobody got time for 
   that! 
   
   ```
   $ dotfiles config --local status.showUntrackedFiles no
   ```

4. **Start tracking your dotfiles**! This is the fun part. 
   
   ```
   $ dotfiles add .profile .bash_aliases
   $ dotfiles commit -m 'initial commit'
   ```

That's it! Now just push your git repo somewhere for safe keeping any syncing 
between machines! I would include instructions on adding a git remote, and 
pushing to GitHub/GitLab, but I'll leave that as an exercise for the reader. 

Happy dot-filing! 

## Setup a new machine

1. Clone this repository:

   ```
   $ git clone --bare git@github.com:calebhailey/dotfiles.git $HOME/.dotfiles 
   ```

2. Configure the `dotfiles` alias:

   ```
   $ alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
   ```

3. Checkout a fresh copy of my dotfiles!

   ```
   $ dotfiles checkout
   ```

## Next 

It's been at least five years since I've attempted to keep my machines so 
organized, so I'm just at the beginning of my journey here. Here's what's 
next for me: 

- Work on a fresh tmux config
- Something something docker something
- Track my sensuctl configs! 

## References

My setup is adapted from [this post on the Atlassian Developer blog][2]. 




[1]: https://git-scm.com/docs/git-init#git-init---bare
[2]: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
