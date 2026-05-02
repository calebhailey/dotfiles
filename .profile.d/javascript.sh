# Javascript Runtimes
# 
# NodeJS, Deno, Bun, and future WinterCG runtimes? 🤞

# NVM
#
# install nvm + nodejs with: 
#
#   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
#   source ${HOME}/.nvm/nvm.sh
#   nvm install --lts
#   nvm alias default 'lts/*'
#   nvm use default
export NVM_DIR="${HOME}/.nvm"
if [ -f "${NVM_DIR}/nvm.sh" ]; then
    source "${NVM_DIR}/nvm.sh"
fi
if [ -f "${NVM_DIR}/bash_completion" ]; then
    source "${NVM_DIR}/bash_completion"
fi

# NodeJS + NPM 
# 
# installed via: nvm install 25
# config file: ${HOME}/.npmrc
# 
# add npm install -g location to PATH
# if [ -x "$(command -v npm)" ]; then
#     PATH="$(npm config get prefix)/bin:${PATH}"
# fi;

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
