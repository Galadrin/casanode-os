TOP_DIR = ${PWD}

MACHINE ?= casanode
DISTRO ?= poky

BASE_DIR = ${PWD}/casanode

CONTAINER_NAME ?= casanode
IMAGE_NAME ?= ${CONTAINER_NAME}

SSTATE_DIR ?= ${HOME}/data/bitbake.sstate
DL_DIR ?= ${HOME}/data/bitbake.downloads

.PHONY:build

# Management of ssh keys : 
#  - pass ssh-agent's socket (SSH_AUTH_SOCK -  will work only if you performed ssh-add in the host for the appropriate keys)
#  - pass ssh configuration folder, including all keys (~/.ssh)
#
# Management of instance name : append ${CONTAINER_INSTCE_NAME_SUFFIX} to name so that multiple instances can run in parallel
# if launched in different contexts
#
REPO_DIR=${BASE_DIR}

# TEMPLATECONF ?= ${BASE_DIR}/sources/meta-casanode/conf/templates/$(patsubst '%',%,${MACHINE})

CMD_REPO_REVISION ?= $(shell git rev-parse --abbrev-ref HEAD)

.PHONY:build

# Management of ssh keys : 
#  - pass ssh-agent's socket (SSH_AUTH_SOCK -  will work only if you performed ssh-add in the host for the appropriate keys)
#  - pass ssh configuration folder, including all keys (~/.ssh)
#
# Management of instance name : append ${CONTAINER_INSTCE_NAME_SUFFIX} to name so that multiple instances can run in parallel
# if launched in different contexts
#
REPO_DIR=${BASE_DIR}

run:build
	${SHARED_RESSOURCE_MKDIR}
	docker run \
	       -it \
	       --rm \
	       -v ${PWD}:${PWD} \
	       -v ${HOME}/.ssh:${HOME}/.ssh \
	       --env SSH_AUTH_SOCK=/ssh-agent \
	       -w ${PWD} \
	       -e REPO_DIR=${REPO_DIR} \
	       -e TEMPLATECONF="${TEMPLATECONF}" \
	       -e MACHINE="${MACHINE}" \
	       -e CMD_REPO_REVISION=${CMD_REPO_REVISION} \
	       --volume ${SSH_AUTH_SOCK}:/ssh-agent  \
	       -v ${HOME}/.ssh/config:${HOME}/.ssh/config \
	       --name "${CONTAINER_NAME}.${CONTAINER_INSTCE_NAME_SUFFIX}" \
	       ${CONTAINER_NAME}:latest \
	       bash -i -c "${PWD}/scripts/post-docker.sh"

build:
	docker build \
	       --build-arg UID=$(shell id -u) \
	       --build-arg USER=${USER} \
	       --build-arg PWD=${PWD} \
	       -t ${IMAGE_NAME} \
	       docker

