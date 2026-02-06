# Set up fzf key bindings and fuzzy completion
if [ $(which fzf) ]; then 
    alias fzf="fzf --tmux"
    eval "$(fzf --bash)"
fi
