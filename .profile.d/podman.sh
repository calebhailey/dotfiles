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
export PODMAN_COMPOSE_PROVIDER=docker-compose
export PODMAN_COMPOSE_WARNING_LOGS=0
if [ -d "/opt/podman" ]; then
    ln -Ffs /opt/podman ${HOME}/.podman 2> /dev/null
    PATH="${HOME}/.podman/bin:${PATH}"
    export KIND_EXPERIMENTAL_PROVIDER=podman
    PODMAN_MACHINE_NAME=podman-machine-default
    PODMAN_MACHINE_INSPECT=$(podman machine inspect "${PODMAN_MACHINE_NAME}" 2> /dev/null)
    PODMAN_STATE=$(printf '%s' "${PODMAN_MACHINE_INSPECT}" | jq -r '.[0].State' 2> /dev/null)
    if [ "${PODMAN_STATE}" = "stopped" ]; then
        podman machine set --memory 4096 "${PODMAN_MACHINE_NAME}"
        podman machine start
    fi
    podman machine ssh rm -r /home/core/.config/containers 2> /dev/null
    podman machine ssh ln -Ffs ${HOME}/.config/containers /home/core/.config/containers 2> /dev/null 
    podman machine ssh sudo sysctl -w vm.max_map_count=1048575 > /dev/null
fi;

# Validate config
ROOTLESS_EXPECTED=$(podman machine ssh printf "\$USER:1001:9001000" 2> /dev/null)
ROOTLESS_ACTUAL=$(podman machine ssh cat /etc/subuid 2> /dev/null)
if [ -n "${ROOTLESS_EXPECTED}" ] && [ -n "${ROOTLESS_ACTUAL}" ] && [ "${ROOTLESS_EXPECTED}" != "${ROOTLESS_ACTUAL}" ]; then
    echo "warning: podman rootless config drift; see ~/.profile.d/podman.sh"
fi;
