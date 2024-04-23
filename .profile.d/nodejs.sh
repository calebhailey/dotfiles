# NodeJS and NPM configuration

# add ~/.local/bin bin directories to $PATH
# NOTE: the only executables I see here are installed via `npm install -g <package>`
#       so I'm assuming this is required for npm to work property. 
# 
# TODO: update npm config to install global packages to a different directory
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi;
