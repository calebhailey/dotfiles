# Podman
#
# installed via: https://podman.io/docs/installation
# removed installed file at: /etc/paths.d/podman-pkg 
if [ -d "/opt/podman" ]; then
    ln -Ffs /opt/podman ${HOME}/.podman 2> /dev/null
    PATH="${HOME}/.podman/bin:${PATH}"
    export KIND_EXPERIMENTAL_PROVIDER=podman
    podman machine ssh rm -r /home/core/.config/containers
    podman machine ssh ln -Ffs /Users/calebhailey/.config/containers /home/core/.config/containers 
fi;
