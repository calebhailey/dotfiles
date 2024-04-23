# if Golang binaries are installed, add them to $PATH
if [ -d "/usr/local/go" ]; then
    GOPATH="$HOME/go"
    PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
fi;
