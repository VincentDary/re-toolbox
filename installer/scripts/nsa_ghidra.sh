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

TOOL_DIR_NAME='nsa_ghidra'

SYS_DEPENDENCIES=(
  'openjdk-21-jdk'
)

SOURCES=(
  'ghidra_11.4.2_PUBLIC_20250826.zip::https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.4.2_build/ghidra_11.4.2_PUBLIC_20250826.zip'
  'BinExport_Ghidra-Java.zip::https://github.com/google/binexport/releases/download/v12-20240417-ghidra_11.0.3/BinExport_Ghidra-Java.zip'
)

get_source_file_name()
{
  echo "${SOURCES[${1}]%%::*}"
}

_ghidra_install()
{
  install_bin=${3:-false}

  # Ghidra
  GHIDRA_ZIP=${1}
  GHIDRA_DIR_NAME=$(unzip -Z -1 "${GHIDRA_ZIP}" | grep -v "/." | head -1)
  GHIDRA_DIR="${INSTALL_TOOL_DIR}/${GHIDRA_DIR_NAME}"
  unzip "${GHIDRA_ZIP}" -d "${INSTALL_TOOL_DIR}"

  if $install_bin
  then
      ln -rs "${GHIDRA_DIR}/ghidraRun" ../bin/ghidra
      ln -rs "${GHIDRA_DIR}/support/analyzeHeadless" ../bin/ghidra-headless
  fi

  # Zynamics/Google Bin Export
  BIN_EXPORT_ZIP_L1="${2}"
  BIN_EXPORT_ZIP_L2=$(unzip -Z -1 "${BIN_EXPORT_ZIP_L1}" | grep -v "/." | head -1)
  unzip "${BIN_EXPORT_ZIP_L1}"
  unzip "${BIN_EXPORT_ZIP_L2}" -d "${GHIDRA_DIR}/Ghidra/Extensions"
}

run_install()
{
  mkdir "${INSTALL_TOOLS_DIR}/ghidra_scripts"

  # ghidra latest
  ghidra_zip_latest="$(get_source_file_name 0)"
  binexport_zip_latest="$(get_source_file_name 1)"
  _ghidra_install "${ghidra_zip_latest}" "${binexport_zip_latest}" true
}
