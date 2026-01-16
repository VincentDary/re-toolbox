#!/usr/bin/env bash

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
set -o xtrace # Turn on traces

###############################################################################
# constants
###############################################################################
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

USER=$1
INSTALL_DIR=$2

INSTALL_BUILD_DIR="${INSTALL_DIR}/build"
INSTALL_TOOLS_DIR="${INSTALL_DIR}/tools"
INSTALL_BIN_DIR="${INSTALL_DIR}/bin"

INSTALLER_SCRIPTS_DIR="${SCRIPT_DIR}/scripts"
INSTALLER_FILES_DIR="${SCRIPT_DIR}/files"

USER_ID=$(id -u "$USER")
USER_GID=$(id -g "$USER")
USER_BASHRC=/home/${USER}/.bashrc

COLOR_RED='\033[0;31m'
COLOR_NC='\033[0m'

INSTALLERS=(
  'conda.sh'
  'qemu.sh'
  'airbus_seclab_cpu_rec.sh'
  'batchdrake_vix.sh'
  'nsa_ghidra.sh'
  'google_bindiff.sh'
)

###############################################################################
# install
###############################################################################

# Dirty workaround related to container issue with gethostbyname not working
# when ip address change.
fix_gethostbyname()
{
  host_ips=$(hostname -I | cut -d\  -f1)
  echo "${host_ips} $(hostname)" > /etc/hosts
  chown "${USER}": /etc/hosts
  chmod ugo=rw /etc/hosts
  cat "${INSTALLER_FILES_DIR}/fix_gethostbyname.sh" >> "${USER_BASHRC}"
}

#------------------------------------------------------------------------------
configure_git()
{
  cp -v "${INSTALLER_FILES_DIR}/.gitconfig" /root
  sudo -u "${USER}" cp -v "${INSTALLER_FILES_DIR}/.gitconfig" "/home/${USER}"
}

#------------------------------------------------------------------------------
install_system_base()
{
  echo 'N' | apt-get --yes install sudo
  pkg_list=$(cat "${INSTALLER_FILES_DIR}/debian_packages.txt")
  apt-get install --yes ${pkg_list}
}

#------------------------------------------------------------------------------
run_script_installer()
{
  install_script=$1

  echo -e "\n${COLOR_RED}run install script: ${install_script}${COLOR_NC}\n"

  # install script constants
  SYS_DEPENDENCIES=()
  SOURCES=()
  TOOL_DIR_NAME=''

  rm -rf "${INSTALL_BUILD_DIR}"
  mkdir -p "${INSTALL_BUILD_DIR}"
  cd "${INSTALL_BUILD_DIR}"

  # shellcheck source=/dev/null
  source "${INSTALLER_SCRIPTS_DIR}/${install_script}"

  # if specified create tool directory
  INSTALL_TOOL_DIR=''
  if [[ -n "${TOOL_DIR_NAME}" ]]; then
      INSTALL_TOOL_DIR="${INSTALL_TOOLS_DIR}/${TOOL_DIR_NAME}"
      mkdir -p "${INSTALL_TOOL_DIR}"
  fi

  # if specified install system dependencies
  for sys_dep in "${SYS_DEPENDENCIES[@]}";
  do
      apt-get install --yes "${sys_dep}"
  done

  # if specified download source files
  for source_item in "${SOURCES[@]}";
  do
      source_file_name="${source_item%%::*}"
      source_url="${source_item#*::}"

      if  [[ "${source_url}" == "git+"* ]] ;
      then
          git_rsc="${source_url#*git+}"
          git_url="${git_rsc%%@*}"
          git_commit="${git_rsc#*@}"

          git clone "${git_url}" "${source_file_name}"
          cd "${source_file_name}"
          git checkout "${git_commit}"
          cd ../
      else
          wget --continue "${source_url}" --output-document "${source_file_name}"
      fi
  done

  # install entry point
  run_install

  rm -rf "${INSTALL_BUILD_DIR}"
}

#------------------------------------------------------------------------------
run_installers()
{
  chmod u+x "${SCRIPT_DIR}/scripts"/*.sh

  for install_script in "${INSTALLERS[@]}";
  do
    run_script_installer "${install_script}"
  done
}

#------------------------------------------------------------------------------
re_toolbox_installer()
{
  # Filesystem setting
  mkdir "${INSTALL_TOOLS_DIR}"
  mkdir "${INSTALL_BIN_DIR}"
  chown -R "${USER_ID}:${USER_GID}" "${INSTALL_DIR}"

  # custom install
  install_system_base
  fix_gethostbyname
  configure_git
  run_installers

  NEW_PATH='${PATH}:'"${INSTALL_BIN_DIR}"
  echo -e "\n\nexport PATH=\"${NEW_PATH}\"\n\n" >> "${USER_BASHRC}"

  # Filesystem setting
  chown -R "${USER_ID}:${USER_GID}" "${INSTALL_DIR}"
  rm -rf "${SCRIPT_DIR}"
}

#------------------------------------------------------------------------------
re_toolbox_installer
