###############################################################################
#
# Copyright 2022-2024 Vincent Dary
#
# This file is part of re-toolbox.
#
# re-toolbox is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# re-toolbox is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# re-toolbox. If not, see <https://www.gnu.org/licenses/>.
#
###############################################################################

###############################################################################
# runtime configuration
###############################################################################
set -o errexit # Exit on error. Append "|| true" if error expected.
set -o nounset # Disallow undefined vars. Use ${VAR:-} for undefined VAR
set -o pipefail
set -o xtrace # Turn on traces

###############################################################################
# Constants
###############################################################################
DOCKER_IMG_NAME=re-toolbox
DOCKER_CONTAINER_NAME=${DOCKER_IMG_NAME}
USER="dev"
INSTALL_DIR_NAME="re-toolbox"

DEV_DIR_CONTAINER="/opt/${INSTALL_DIR_NAME}"

HOME_DIR=$(realpath ~)
HOME_DIR_INSTALL="${HOME_DIR}/${INSTALL_DIR_NAME}"
DEV_DIR="${DEV_DIR:-${HOME_DIR_INSTALL}}"

set -e

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
INSTALLER_DIR_NAME=installer

###############################################################################
# build image
###############################################################################

docker build \
  --build-arg USERNAME="${USER}" \
  --build-arg CONTAINER_DEV_DIR="${DEV_DIR_CONTAINER}" \
  --no-cache \
  --progress plain \
  -t ${DOCKER_IMG_NAME} .

###############################################################################
# create container
###############################################################################

mkdir -p "${DEV_DIR}"

DEV_DIR="${DEV_DIR}" \
DEV_DIR_CONTAINER="${DEV_DIR_CONTAINER}" \
DOCKER_IMG_NAME=${DOCKER_IMG_NAME} \
DOCKER_CONTAINER_NAME=${DOCKER_CONTAINER_NAME} \
  docker-compose up -d

###############################################################################
# run installer
###############################################################################

cp -r "${SCRIPT_DIR}/${INSTALLER_DIR_NAME}" "${DEV_DIR}"

echo -e '[i] set installer perm'
docker exec -u root -it "${DOCKER_CONTAINER_NAME}" \
  chmod u+x "${DEV_DIR_CONTAINER}/${INSTALLER_DIR_NAME}/install.sh"

echo -e '[i] run installer'
docker exec -u root -it "${DOCKER_CONTAINER_NAME}" \
  "${DEV_DIR_CONTAINER}/${INSTALLER_DIR_NAME}/install.sh" \
    ${USER} "${DEV_DIR_CONTAINER}"
