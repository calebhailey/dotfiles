# pipegrepper aliases
function lowercase() {
  tr '[:upper:]' '[:lower:]'
}
function uppercase() {
  tr '[:lower:]' '[:upper:]'
}

# container aliases
alias workstation="podman run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ${HOME}:/home/me -it calebhailey/workstation:latest"

function http-server() {
    NAME="$(basename ${PWD})-httpd"
    PORT=${1:-8080}
    SRC=${2:-$PWD}
    if [ $(podman ps | grep ${NAME} | wc -l) -ne 0 ]; then
        echo "Container \"${NAME}\" is already running"; return 1
    fi
    if [ $(lsof -i tcp:${PORT} | wc -l) -ne 0 ]; then
        echo "Port ${PORT} is already in use"; return 1
    fi
    echo "Serving web content at: $SRC"
    podman run -d --rm --name ${NAME} -p "${PORT}:80" \
                -v "${HOME}/.nginx/nginx-web.conf:/etc/nginx/nginx.conf" \
                -v "${SRC}:/usr/share/nginx/html" nginx:latest
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

# AWS aliases

# Resolve AWS ARN
#
# Fill in missing AWS ARN components using the AWS CLI and environment variables.
resolve_aws_arn() {
    ARN=$1
    PREFIX=$(echo $ARN | cut -d':' -f1)
    PROVIDER=$(echo $ARN | cut -d':' -f2)
    SERVICE=$(echo $ARN | cut -d':' -f3)
    REGION=$(echo $ARN | cut -d':' -f4)
    ACCOUNT=$(echo $ARN | cut -d':' -f5)
    RESOURCE=$(echo $ARN | cut -d':' -f6-)
    if [ -z ${REGION} ] && [ "${SERVICE}" != "iam" ]; then
        REGION=${AWS_REGION:-$(aws configure list | grep region | awk '{print $2}')}
    fi
    if [ -z ${ACCOUNT} ]; then
        ACCOUNT=${AWS_ACCOUNT_ID:-$(aws sts get-caller-identity --query \"Account\" --output text)}
    fi
    printf "${PREFIX:-arn}:${PROVIDER:-aws}:${SERVICE}:${REGION}:${ACCOUNT}:${RESOURCE}\n"
};

# Parse AWS ARN and return specific components
#
# References:
# - https://docs.aws.amazon.com/managedservices/latest/userguide/find-arn.html
parse_aws_arn() {
    ARN=$1
    PREFIX=$(echo $ARN | cut -d':' -f1)
    PROVIDER=$(echo $ARN | cut -d':' -f2)
    SERVICE=$(echo $ARN | cut -d':' -f3)
    REGION=$(echo $ARN | cut -d':' -f4)
    ACCOUNT=$(echo $ARN | cut -d':' -f5)
    RESOURCE=$(echo $ARN | cut -d':' -f6-)
    RESOURCE_ID="$${RESOURCE}"
    RESOURCE_TYPE="unknown"
    if [ $(echo $RESOURCE | tr '/' ' ' | wc -w) -eq 2 ]; then
        RESOURCE_TYPE=$(echo $RESOURCE | cut -d'/' -f1)
        RESOURCE_ID=$(echo $RESOURCE | cut -d'/' -f2)
    elif [ $(echo $RESOURCE | tr ':' ' ' | wc -w) -eq 2 ]; then
        RESOURCE_TYPE=$(echo $RESOURCE | cut -d':' -f1)
        RESOURCE_ID=$(echo $RESOURCE | cut -d':' -f2)
    fi
    case $(echo $2 | tr '[:upper:]' '[:lower:]') in
        service) echo $SERVICE;;
        region) echo $REGION;;
        account) echo $ACCOUNT;;
        resource) echo $RESOURCE;;
        id) echo $RESOURCE_ID;;
        type) echo $RESOURCE_TYPE;;
        *) printf 'PREFIX="%s"\nPROVIDER="%s"\nSERVICE="%s"\nREGION="%s"\nACCOUNT="%s"\nRESOURCE="%s"\n' "${PREFIX}" "${PROVIDER}" "${SERVICE}" "${REGION}" "${ACCOUNT}" "${RESOURCE}";;
    esac
};

