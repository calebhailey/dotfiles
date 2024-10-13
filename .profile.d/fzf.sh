# Set up fzf key bindings and fuzzy completion
if [ $(command -v fzf) ]; then 
    alias fzf="fzf --tmux"
    eval "$(fzf --bash)"
fi
