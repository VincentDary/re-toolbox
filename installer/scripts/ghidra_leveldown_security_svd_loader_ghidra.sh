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

SOURCES=(
  'leveldown-security_SVD-Loader-Ghidra::git+https://github.com/leveldown-security/SVD-Loader-Ghidra.git@4b21fa54a1f516e25e959939f6e1251263c74725'
)

run_install()
{
  mv ./leveldown-security_SVD-Loader-Ghidra "${INSTALL_TOOLS_DIR}/ghidra_scripts"
}