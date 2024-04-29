# Dotfiles
# 
# reference: https://github.com/calebhailey/dotfiles

# Alias
alias dotfiles='/usr/bin/git --git-dir=/Users/calebhailey/.dotfiles --work-tree=/Users/calebhailey'
 
# Assume unchanged
# 
# enable with `dotfiles update-index --assume-unchanged <file>`
# revert with `dotfiles update-index --no-assume-unchanged <file>`
# add with `dotfiles add <file>` as normal
dotfiles update-index --assume-unchanged .ssh/config
dotfiles update-index --assume-unchanged .gitconfig
