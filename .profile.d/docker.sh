# command aliases
alias docker="podman"

# docker remote API
# https://success.docker.com/article/how-do-i-enable-the-remote-api-for-dockerd
# TODO: do I still need this now that I'm using podman? 
if [ "$(curl --no-buffer -XGET -s -I -f http://127.0.0.1:2376/containers/json)" ]; then 
    export DOCKER_HOST="tcp://127.0.0.1:2376"
fi;
