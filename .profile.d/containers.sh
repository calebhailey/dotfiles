alias downloader="podman run --rm -it -v \${PWD}:/downloads --workdir /downloads alpine:latest /bin/ash"
alias yt-dlp="podman run --rm -it -v \${PWD}:/downloads calebhailey/yt-dlp:latest /bin/bash"
