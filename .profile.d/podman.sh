# Podman
#
# installed via: https://podman.io/docs/installation
# removed installed file at: /etc/paths.d/podman-pkg 
# 
# Podman machine config:
# podman machine init --now
# podman machine ssh rm -r /home/core/.config/containers
# podman machine ssh ln -Ffs ${HOME}/.config/containers /home/core/.config/containers
#
# Podman rootless config:
# podman machine ssh
# printf "$USER:1001:9001000\n" | sudo tee /etc/subuid | sudo tee /etc/subgid
# podman system migrate
#
# Podman registry config:
# podman volume create registry
# podman container create --name registry -p 5001:5000 --volume registry:/var/lib/registry/ registry:2
# podman start registry
if [ -d "/opt/podman" ]; then
    ln -Ffs /opt/podman ${HOME}/.podman 2> /dev/null
    PATH="${HOME}/.podman/bin:${PATH}"
    export KIND_EXPERIMENTAL_PROVIDER=podman
    podman machine ssh rm -r /home/core/.config/containers
    podman machine ssh ln -Ffs ${HOME}/.config/containers /home/core/.config/containers 
    # podman machine ssh rm -r /home/core/.local/containers
    # podman machine ssh ln -Ffs ${HOME}/.local/containers
fi;
