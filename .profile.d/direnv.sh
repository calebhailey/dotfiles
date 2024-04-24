# direnv
#
# installed via: https://github.com/direnv/direnv/releases
# 
#   DIRENV_VERSION=v2.34.0 curl -LO https://github.com/direnv/direnv/releases/download/${DIRENV_VERSION}/direnv.darwin-arm64
#   chmod +x direnv.darwin-arm64 
#   sudo mv direnv.darwin-arm64 /usr/local/bin/direnv
# 
if [ "$(which direnv)" ]; then
    eval "$(direnv hook bash)"
fi;
