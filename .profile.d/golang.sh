# if Golang binaries are installed, add them to $PATH
if [ -d "/usr/local/go" ]; then
    PATH="/usr/local/go/bin:${PATH}"
fi;
