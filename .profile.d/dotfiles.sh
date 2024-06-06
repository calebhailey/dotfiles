# Dotfiles
# 
# reference: https://github.com/calebhailey/dotfiles

# Alias
alias dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}/"
 
# Skip worktree(s) 
# 
# enable with `dotfiles update-index --skip-worktree <file>`
# revert with `dotfiles update-index --no-skip-worktree <file>`
# observe with `dotfiles ls-files -v`
# add changes with `dotfiles add <file>` as normal
dotfiles update-index --skip-worktree .ssh/config
dotfiles update-index --skip-worktree .gitconfig
dotfiles update-index --skip-worktree .config/containers/registries.conf

