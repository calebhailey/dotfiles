# if Bun binaries are installed, add them to $PATH
if [ -d "$HOME/.bun" ]; then
    BUN_INSTALL="$HOME/.bun" 
    PATH="$PATH:$BUN_INSTALL/bin" 
fi;
