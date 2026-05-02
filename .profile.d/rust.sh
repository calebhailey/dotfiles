# installed via:
# 
#   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
if [ -x "$(command -v cargo)" ]; then
    source "${HOME}/.cargo/env"
fi
