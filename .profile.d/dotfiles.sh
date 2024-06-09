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
dotfiles update-index --skip-worktree "${HOME}/.ssh/config"
dotfiles update-index --skip-worktree "${HOME}/.gitconfig"
dotfiles update-index --skip-worktree "${HOME}/.config/containers/registries.conf"

