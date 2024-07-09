# Tmux
# 
# NOTE: on macos, install via nix & copy to /usr/local/bin/tmux

# rejoin active tmux sessions (if any)
if [ $(which tmux) ] && [ -z $TMUX ]; then
  tmux new-session -A -s default
fi;
