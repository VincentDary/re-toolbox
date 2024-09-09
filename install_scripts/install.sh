#!/bin/bash

################################################################################
#
# Copyright 2022-2024 Vincent Dary
#
# This file is part of re-toolbox.
#
# acid-box is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# acid-box is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# acid-box. If not, see <https://www.gnu.org/licenses/>.
#
################################################################################

set -e

INSTALLERS=(
  'pkg_airbus_seclab_cpu_rec.sh'
  'pkg_nsa_ghidra.sh'
  'pkg_google_bindiff.sh'
  'pkg_batchdrake_vix.sh'
)

USER=toolbox
INSTALL_FILES=/opt/install_files
INSTALL_SCRIPTS=/opt/install_scripts
INSTALL_DIR_TOOLS=/opt/tools

# Git configuration
cp -v "${INSTALL_FILES}/.gitconfig" /root
cp -v "${INSTALL_FILES}/.gitconfig" /toolbox

# Base system package install
apt-get install -y $(cat "${INSTALL_SCRIPTS}/debian_packages.txt")

# Python config
ln -s /usr/bin/python3 /usr/bin/python

echo "[i] custom package install"

mkdir "${INSTALL_DIR_TOOLS}"
chown -R ${USER}: "${INSTALL_DIR_TOOLS}"

for install_file in "${INSTALLERS[@]}";
do
    SYS_DEPENDENCY=()
    SOURCE=()
    PKG_DIR=''
    INSTALL_BANNER=''
    source "${INSTALL_SCRIPTS}/${install_file}"
    mkdir "${INSTALL_DIR_TOOLS}/${PKG_DIR}"
    cd "${INSTALL_DIR_TOOLS}/${PKG_DIR}"

    for sys_dep in "${SYS_DEPENDENCY[@]}";
    do
        apt-get install -y "${sys_dep}"
    done

    for source_item in "${SOURCE[@]}";
    do
        source_file_name="${source_item%%::*}"
        source_url="${source_item#*::}"

        if  [[ "${source_url}" == "git+"* ]] ;
        then
            git_rsc="${source_url#*git+}"
            git_url="${git_rsc%%@*}"
            git_commit="${git_rsc#*@}"

            git clone "${git_url}"
            cd "${source_file_name}"
            git checkout ${git_commit}
            cd ../
        else
            wget "${source_url}"
        fi
    done

    install
done

echo "[i] custom package post install configuration"

source "${INSTALL_SCRIPTS}/post_install_config.sh"
post_install_config

chown -R ${USER}: "${INSTALL_DIR_TOOLS}"
