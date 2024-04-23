# Generic aliases
alias ll="ls -al"
alias l="pwd"
alias b="cd $OLDPWD"

# Cross-platform aliases (Linux ↔︎ Mac)
alias pbcopy="tee \$HOME/.clipboard > /dev/null"
alias pbpaste="cat \$HOME/.clipboard"

# Workstation aliases
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias ntpdate="sudo sntp -sS time.nist.gov"

# IP Tables aliases
alias open-port="sudo iptables -A INPUT -p tcp -m tcp -j ACCEPT --dport"
alias close-port="sudo iptables -D INPUT -p tcp -m tcp -j ACCEPT --dport"

# Dev tooling aliases
alias sqlite3="sqlite3 -column -header"
alias assume="source assume"
