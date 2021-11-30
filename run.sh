#!/usr/bin/env bash

set -e

function error {
    echo "Error: confluent-replicator-config: $1"
    exit 1
}

# Parse tags
DEFAULT_ANSIBLE_TAGS=""
ANSIBLE_TAGS=""
CHECK_FLAG=""
VERBOSITY_FLAG=""
PREV_IFS="$IFS"
IFS=","
for tag in ${TAGS}; do
    if [[ "$tag" == "check" ]]; then
        CHECK_FLAG="--check"
    elif [[ "$tag" =~ ^v|^vv|^vvv ]]; then
        VERBOSITY_FLAG="-${tag}"
    else
        if [ -z "$ANSIBLE_TAGS" ]; then
            ANSIBLE_TAGS="${tag}"
        else
            ANSIBLE_TAGS="${ANSIBLE_TAGS},${tag}"
        fi
    fi
done
IFS="$PREV_IFS"

set -u

# If no task specific tags passed, default to all
if [ -z "$ANSIBLE_TAGS" ]; then
    # echo "No tags passed, using default set:"
    # echo "${DEFAULT_ANSIBLE_TAGS}"
    ANSIBLE_TAGS="$DEFAULT_ANSIBLE_TAGS"
fi

SSH_KEY="~/.ssh/eu-west-1_${ENVIRONMENT}_kafka.pem"

# Run apply playbook
ansible-playbook \
    --extra-vars "ansible_user=ubuntu env=${ENVIRONMENT} cluster_name=${CLUSTER_NAME}" \
    --extra-vars "@${PROJECT_DIR}/config/${CLUSTER_NAME}/${REGION}/${ENVIRONMENT}.yml" \
    --private-key $SSH_KEY \
    --tags "${ANSIBLE_TAGS}" \
    --vault-id ~/.ansible/.vault-pass.all \
    $CHECK_FLAG ${VERBOSITY_FLAG} ${PROJECT_DIR}/plays/apply.yml
