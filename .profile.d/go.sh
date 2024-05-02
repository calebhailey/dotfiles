# if Golang binaries are installed, add them to $PATH
#
# assumes ln -Ffs /usr/local/go/bin/go /usr/local/bin/go
if [ -x "$(command -v go)" ]; then
    export GOPATH="${HOME}/.golang/"
    export GOBIN="${HOME}/.golang/bin"
    mkdir -p ${GOBIN}
    PATH="${GOBIN}:${PATH}"
fi;
