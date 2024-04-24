# bash prompt
# 
case $(uname -s) in
  Darwin)
    HOSTNICKNAME=$(hostname | cut -d'.' -f1)
    export PS1="\[\e[1;32m\]${HOSTNICKNAME} \[\e[m\]\\$ "
    ;;
  Linux)
    if [ "$(hostname)" == "penguin" ]; then
      export PS1="\[\e[1;32m\]pixelbook \[\e[m\]\\$ "
    elif [ -f /run/.containerenv ]; then
      export PS1="\[\e[1;32m\]workstation \[\e[m\]\\$ "
    else
      export PS1="\[\e[1;32m\]$(hostname) \[\e[m\]\\$ "
    fi
    ;;
  *)
    export PS1="\[\e[1;32m\]computer \[\e[m\]\\$ "
    ;;
esac;
