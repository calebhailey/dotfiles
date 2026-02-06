# Tmux
# 
# NOTE: on macos, install via nix & copy to /usr/local/bin/tmux
# rejoin active tmux sessions (if any)
if [ $(command -v tmux) ] && [ -z $TMUX ]; then
    if [ $(tmux ls | wc -l) -gt 1 ]; then 
        echo
        tmux ls
    else
        tmux new-session -A -s default
    fi;
fi;
