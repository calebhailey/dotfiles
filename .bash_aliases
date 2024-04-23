# Generic aliases
alias ll="ls -al"
alias l="pwd"
alias b="cd $OLDPWD"

# Clipboard aliases
alias pbcopy="tee \$HOME/.clipboard > /dev/null"
alias pbpaste="cat \$HOME/.clipboard"

# Mac compat aliases
if [ -n "$(uname -a | grep Darwin)" ]; then
  alias ssh-add="ssh-add --apple-use-keychain"
fi

# Workstation aliases
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias new-ssh-key="ssh-keygen -t rsa -b 4096 -C $1"
alias ntpdate="sudo sntp -sS time.nist.gov"
alias workstation="podman run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ${HOME}:/home/me -it calebhailey/workstation:latest"

# IP Tables aliases
alias open-port="sudo iptables -A INPUT -p tcp -m tcp -j ACCEPT --dport"
alias close-port="sudo iptables -D INPUT -p tcp -m tcp -j ACCEPT --dport"

# Dev tooling aliases
alias sqlite3="sqlite3 -column -header"
alias docker="podman"

# Docker aliases
alias http-server="\
  ID=\$(podman run -d --rm --name \$(basename \$PWD) -p :80 \
    -v \"$HOME/.nginx/nginx-web.conf:/etc/nginx/nginx.conf\" \
    -v \"\$PWD:/usr/share/nginx/html\" nginx:latest) \
  && echo \$ID && podman port \$ID"
alias file-server="\
  ID=\$(sudo docker run -d --rm --name \$(basename \$PWD) -p :80 \
    -v \"$HOME/.nginx/nginx-files.conf:/etc/nginx/nginx.conf\" \
    -v \"\$PWD:/usr/share/nginx/html\" nginx:latest) \
  && echo \$ID && sudo docker port \$ID"

