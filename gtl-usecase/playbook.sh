#!/usr/bin/env bash

set -euo pipefail

ANSIBLE_DIR="/home/buildbot/dbcode-gtl/DBA/ansible"
ANSIBLE_PLAYBOOKS_DIR="$ANSIBLE_DIR/playbooks"
ANSIBLE_EXTRA_VARS=$(echo "${ANSIBLE_EXTRA_VARS:-}" | sed -e 's/[<>&*|;$#~!`\\]/WARNING/g')
ANSIBLE_HOSTGROUP=$(echo "$ANSIBLE_HOSTGROUP" | sed -e 's/[<>&*|;$#~!`\\]/WARNING/g')
ANSIBLE_INVENTORY=$(echo "$ANSIBLE_INVENTORY" | sed -e 's/[<>&*|;$#~!`\\]/WARNING/g')


run() {
	ANSIBLE_EXTRA_VARS="${ANSIBLE_EXTRA_VARS} ansible_hostgroup=${ANSIBLE_HOSTGROUP}"
	
	#env ANSIBLE_FORCE_COLOR=True ansible-playbook -vv ${ANSIBLE_DIR}/${ANSIBLE_PLAYBOOKS_DIR}/testing-1.yaml --extra-vars "${ANSIBLE_EXTRA_VARS}"
    env ANSIBLE_FORCE_COLOR=True ansible-playbook -vv ${ANSIBLE_PLAYBOOKS_DIR}/script-tiven.yaml --extra-vars "${ANSIBLE_EXTRA_VARS}" --inventory "./inventories/${ANSIBLE_INVENTORY}/" 


env ANSIBLE_FORCE_COLOR=True \
		ANSIBLE_DEPRECATION_WARNINGS=False \
		ANSIBLE_TRANSFORM_INVALID_GROUP_CHARS=ignore \
		ansible-playbook \
		--inventory "./inventories/${ANSIBLE_INVENTORY}/" \
		--vault-password-file "../files/credentials/vault-password-default" \
		--extra-vars "${ANSIBLE_EXTRA_VARS}" \
		--tags ${ANSIBLE_TAGS} \
		--skip-tags always ${ANSIBLE_LIMITS} \
		${ANSIBLE_PLAYBOOKS_DIR}/pg_initiator.yaml 2>/dev/null

}

main() {
#    cd "$ANSIBLE_DIR" || exit 1
	run
}

main "$@"
