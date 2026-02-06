# discovery current execution context
export CLOUD_PROVIDER="none"
if [ -f /run/.containerenv ]; then
    CLOUD_PROVIDER="podman"
elif [ -f /.dockerenv ]; then
    CLOUD_PROVIDER="docker"
elif [ -f /var/run/secrets/kubernetes.io ]; then
    CLOUD_PROVIDER="kubernetes"
fi
