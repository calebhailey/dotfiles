# container aliases
alias workstation="podman run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ${HOME}:/home/me -it calebhailey/workstation:latest"
alias http-server="\
    ID=\$(podman run -d --rm --name \$(basename \$PWD) -p ${1}:80 \
          -v \"$HOME/.nginx/nginx-web.conf:/etc/nginx/nginx.conf\" \
          -v \"\$PWD:/usr/share/nginx/html\" nginx:latest) \
    && echo \$ID && podman port \$ID"
alias file-server="\
    ID=\$(sudo docker run -d --rm --name \$(basename \$PWD) -p \"${1}:80\" \
          -v \"$HOME/.nginx/nginx-files.conf:/etc/nginx/nginx.conf\" \
          -v \"\$PWD:/usr/share/nginx/html\" nginx:latest) \
    && echo \$ID && sudo docker port \$ID"
