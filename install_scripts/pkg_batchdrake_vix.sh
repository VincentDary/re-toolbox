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

INSTALL_BANNER='BatchDrake Vix'
PKG_DIR='batchdrake_vix'
SOURCE=(
  'vix::git+https://github.com/BatchDrake/vix@824b6755157a0f7430a0be0af454487d1492204d'
)
SYS_DEPENDENCY=(
  'autoconf'
  'libsdl1.2-dev'
  'libsdl1.2debian'
  'libtool'
)

install()
{
  cd vix || exit
  libtoolize
  autoreconf -fvi
  ./configure
  make
  make install
}
