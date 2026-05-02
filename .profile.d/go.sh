# Configure GOPATH and GOBIN (for tools install with go install)
if [ -x "$(command -v go)" ]; then
    export GOPATH="${HOME}/.golang/"
    export GOBIN="${HOME}/.golang/bin"
    mkdir -p ${GOBIN}
    PATH="${GOBIN}:${PATH}"
fi;
