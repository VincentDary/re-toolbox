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

INSTALL_BANNER='NSA Ghidra'
PKG_DIR='nsa_ghidra'
SOURCE=(
  'ghidra_11.0.1_PUBLIC_20240130.zip::https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.0.1_build/ghidra_11.0.1_PUBLIC_20240130.zip'
)
SYS_DEPENDENCY=(
  'openjdk-17-jdk'
)

install()
{
  pkg_name="${SOURCE[0]%%::*}"
  unzip "${pkg_name}"
  rm -f "${pkg_name}"
  ghidra_dir=$(realpath "$(ls -1)")
  ln -s "${ghidra_dir}/ghidraRun" /usr/bin/ghidra
  ln -s "$(pwd)/${ghidra_dir}/support/analyzeHeadless" /usr/bin/ghidra-headless
}
