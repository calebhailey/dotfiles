# Overview

Nothing to see here, just attempting to keep my dotfiles in sync between systems.

## Guide

If you're curious how my dotfiles project works, here's how I set it up.

The basic idea is:

- Store the Git directory at `$HOME/.dotfiles`
- Use `$HOME` as the working tree
- Create a `$HOME/.git` file that points Git at `$HOME/.dotfiles`

This lets normal Git commands work from `$HOME` without needing a custom alias.

## Initial setup

1. **Initialize the dotfiles repository**.

   ```sh
   git init --bare "$HOME/.dotfiles"
   ```

2. **Tell Git that `$HOME` is the work tree**.

   ```sh
   git --git-dir="$HOME/.dotfiles" config core.bare false
   git --git-dir="$HOME/.dotfiles" config core.worktree "$HOME"
   ```

3. **Create a `.git` stub file**.

   ```sh
   printf 'gitdir: .dotfiles\n' > "$HOME/.git"
   ```

   The file should look like this:

   ```text
   gitdir: .dotfiles
   ```

   The path is relative to `$HOME/.git`, so this keeps the setup portable
   across machines where `$HOME` may have a different absolute path.

4. **Disable untracked files**.

   This is important, otherwise Git will warn about every untracked file in
   your home directory.

   ```sh
   git config --local status.showUntrackedFiles no
   ```

5. **Start tracking dotfiles**.

   ```sh
   git add .profile .bash_aliases
   git commit -m 'initial commit'
   ```

That's it. Now normal Git commands work from `$HOME`:

```sh
git status
git add .profile
git commit -m 'update profile'
git push
```

## Setup a new machine

1. Clone this repository:

   ```sh
   git clone --bare git@github.com:calebhailey/dotfiles.git "$HOME/.dotfiles"
   ```

2. Configure the repository:

   ```sh
   git --git-dir="$HOME/.dotfiles" config core.bare false
   git --git-dir="$HOME/.dotfiles" config core.worktree "$HOME"
   git --git-dir="$HOME/.dotfiles" config status.showUntrackedFiles no
   ```

3. Create the `.git` stub file:

   ```sh
   printf 'gitdir: .dotfiles\n' > "$HOME/.git"
   ```

4. Checkout the dotfiles:

   ```sh
   git checkout
   ```

If checkout fails because files already exist, move or remove the conflicting
files, then run `git checkout` again.

## Notes

This setup started as a bare repository pattern, but after setting
`core.bare false`, Git treats `$HOME/.dotfiles` as a normal Git directory stored
outside the working tree.

Be careful with destructive Git commands from `$HOME`:

```sh
git reset --hard
git clean -fd
```

Those commands operate against your home directory.

I do not track `$HOME/.git` itself. I treat it as generated machine-local state.

## Next

It's been at least five years since I've attempted to keep my machines so
organized, so I'm just at the beginning of my journey here. Here's what's next
for me:

- Work on a fresh tmux config
- Something something docker something
- Track my sensuctl configs

## References

My original setup was adapted from [this post on the Atlassian Developer blog][2].

[1]: https://git-scm.com/docs/git-init#git-init---bare
[2]: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
