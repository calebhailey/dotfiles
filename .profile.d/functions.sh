# container aliases
alias workstation="podman run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ${HOME}:/home/me -it calebhailey/workstation:latest"

function http-server() {
    NAME="$(basename ${PWD})-httpd"
    PORT=${1:-8080}
    if [ $(podman ps | grep ${NAME} | wc -l) -ne 0 ]; then
        echo "Container \"${NAME}\" is already running"; return 1
    fi
    if [ $(lsof -i tcp:${PORT} | wc -l) -ne 0 ]; then
        echo "Port ${PORT} is already in use"; return 1
    fi
    podman run -d --rm --name ${NAME} -p "${PORT}:80" \
                -v "${HOME}/.nginx/nginx-web.conf:/etc/nginx/nginx.conf" \
                -v "${PWD}:/usr/share/nginx/html" nginx:latest
    if [ $? -ne 0 ]; then return 1; fi
    podman port ${NAME}
}

function file-server() {
    NAME="$(basename ${PWD})-httpd"
    PORT=${1}
    podman run -d --rm \
               --name ${NAME} -p "${PORT}:80" \
               -v "${HOME}/.nginx/nginx-files.conf:/etc/nginx/nginx.conf" \
               -v "${PWD}:/usr/share/nginx/html" nginx:latest
    if [ $? -ne 0 ]; then return 1; fi
    podman port ${NAME}
}
