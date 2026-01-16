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

SYS_DEPENDENCIES=(
  'autoconf'
  'libsdl1.2-dev'
  'libsdl1.2debian'
  'libtool'
)

SOURCES=(
  'vix::git+https://github.com/BatchDrake/vix@824b6755157a0f7430a0be0af454487d1492204d'
)

run_install()
{
  tool_dir="${INSTALL_TOOLS_DIR}/batchdrake_vix"
  mv vix "${tool_dir}"
  cd "${tool_dir}" || exit 1

  libtoolize
  autoreconf -fvi
  ./configure
  make
#  make install
  ln -rs src/vix ../../bin/vix
}

