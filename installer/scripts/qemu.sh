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
  'qemu-utils'
  'qemu-system-gui'
  'qemu-system-arm'
  'qemu-system-mips'
  'qemu-system-ppc'
  'qemu-system-riscv'
  'qemu-system-sparc'
  'qemu-system-x86'
)

run_install()
{
  echo 'qemu install'
}
