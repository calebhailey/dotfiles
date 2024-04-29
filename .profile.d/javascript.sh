# Javascript Runtimes
# 
# NodeJS, Deno, Bun, and future WinterCG runtimes? 🤞

# NodeJS + NPM 
# 
# installed via: https://nodejs.org/en/download/current
# config file: ${HOME}/.npmrc
# 
# add npm install -g location to PATH
if [ -x "$(command -v npm)" ]; then
    PATH="$(npm config get prefix)/bin:${PATH}"
fi;

# Deno
# 
# install via: https://docs.deno.com/runtime/manual/getting_started/installation
# see deno --help for more information on DENO_ environment variables
# 
# set DENO_INSTALL_ROOT and add it to PATH
if [ -x "$(command -v deno)" ]; then
    mkdir -p ${HOME}/.deno/bin
    export DENO_INSTALL_ROOT="${HOME}/.deno/bin"
    PATH="${DENO_INSTALL_ROOT}:${PATH}"
fi;
