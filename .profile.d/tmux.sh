# Tmux
# 
# NOTE: on macos, install via nix & copy to /usr/local/bin/tmux

# rejoin active tmux sessions (if any)
if [ $(which tmux) ]; then
  if [ !$(tmux list-sessions > /dev/null 2>&1) ] && [ -z $TMUX ]; then
    tmux attach -d
  fi;
fi;
