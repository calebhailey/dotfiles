# Podman
#
# installed via: https://podman.io/docs/installation
# removed installed file at: /etc/paths.d/podman-pkg 
if [ -d "/opt/podman" ]; then
    ln -Ffs /opt/podman ${HOME}/.podman 2> /dev/null
    PATH="${HOME}/.podman/bin:${PATH}"
fi;
