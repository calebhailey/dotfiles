# Dotfiles
# 
# reference: https://github.com/calebhailey/dotfiles
 
# Skip worktree(s) 
# 
# enable with `git update-index --skip-worktree <file>`
# revert with `git update-index --no-skip-worktree <file>`
# observe with `git ls-files -v`
# add changes with `git add <file>` as normal
git --git-dir="${HOME}/.dotfiles" --work-tree="${HOME}" update-index --skip-worktree ".ssh/config"
git --git-dir="${HOME}/.dotfiles" --work-tree="${HOME}" update-index --skip-worktree ".gitconfig"
git --git-dir="${HOME}/.dotfiles" --work-tree="${HOME}" update-index --skip-worktree ".config/containers/registries.conf"
