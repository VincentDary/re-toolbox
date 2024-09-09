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

INSTALL_BANNER='Google BinDiff'
PKG_DIR='google_bindiff'
SOURCE=(
  'bindiff_8_amd64.deb::https://github.com/google/bindiff/releases/download/v8/bindiff_8_amd64.deb'
)

install()
{
  bindiff_deb=${SOURCE[0]%%::*}
  apt-get install -y "./${bindiff_deb}"
  rm -f "${bindiff_deb}"
}
