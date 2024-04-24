# SSH
# 
# aliases
alias new-ssh-key="ssh-keygen -t rsa -b 4096 -C $1"
if [ -n "$(uname -a | grep Darwin)" ]; then
    alias ssh-add="ssh-add --apple-use-keychain"
fi

# ssh keys
eval "$(ssh-agent -s)" > /dev/null
for KEY in $(ls $HOME/.ssh/* 2> /dev/null)
do
    if ( file $KEY | grep -iq "OpenSSH private" ); then 
        ssh-add $KEY &> /dev/null 
        echo "identity \"$(basename ${KEY})\" added"
    elif ( file $KEY | grep -iq "PEM RSA" ); then
        ssh-add $KEY &> /dev/null
        echo "identity \"$(basename ${KEY})\" added"
    fi
done;
