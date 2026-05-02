## Aliases =====================================================================
##
## NOTE: Use type <command> instead of which <command> to resolve aliases and functions.

alias ll="ls -al"
alias l="pwd"
alias b="cd $OLDPWD"
alias path="echo $PATH | tr ':' '\n'"
alias ntpdate="sudo sntp -sS time.nist.gov"
alias open-port="sudo iptables -A INPUT -p tcp -m tcp -j ACCEPT --dport"
alias close-port="sudo iptables -D INPUT -p tcp -m tcp -j ACCEPT --dport"
alias sqlite3="sqlite3 -column -header"
alias assume="source assume"
alias whatismyip="curl -s https://checkip.amazonaws.com"
alias unquarantine="xattr -d com.apple.quarantine"
alias lowercase="tr '[:upper:]' '[:lower:]'"
alias uppercase="tr '[:lower:]' '[:upper:]'"

## Linux aliases
if ! command -v pbcopy >/dev/null 2>&1; then
  alias pbcopy="tee \$HOME/.clipboard > /dev/null"
  alias pbpaste="cat \$HOME/.clipboard"
fi

## GitLab Aliases
alias ci_commit_ref_slug="echo \$(git rev-parse --abbrev-ref HEAD | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g; s/^-//; s/-$//; s/(.{1,63}).*/\1/')"
alias gitlab_ci_jobs="glab ci get --with-job-details"
alias gitlab_ci_trace="glab ci trace --pipeline-id"

## FUNCTIONS ===================================================================

# recursive find & delete functions
#
# usage:
#   findall *.db.* 
findall() { find . -type f -name "$1"; }
deleteall() { find . -type f -name "$1" -delete; }


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
