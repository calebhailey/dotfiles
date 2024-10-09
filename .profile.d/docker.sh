# Docker
# 
# install via: https://docs.docker.com/desktop/install/mac-install/
#
# alternatively, download docker-compose and docker-credential-* helpers from:
# * https://github.com/docker/compose/releases
# * https://github.com/docker/docker-credential-helpers/releases
# 
# configure credential helpers at ~/.docker/config.json; set "credsStore" to "osxkeychain" or "pass" (not "desktop")
#
# docker remote API
# https://success.docker.com/article/how-do-i-enable-the-remote-api-for-dockerd
#if [ "$(curl --no-buffer -XGET -s -I -f http://127.0.0.1:2376/containers/json)" ]; then 
#    export DOCKER_HOST="tcp://127.0.0.1:2376"
#fi;
