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

INSTALL_BANNER='Airbus Seclab cpu_rec'
PKG_DIR='airbus_seclab_cpu_rec'
SOURCE=(
  'cpu_rec::git+https://github.com/airbus-seclab/cpu_rec.git@6b192399cd56ad6953e568e1263024dd8a4ef38d'
)

install()
{
  ln -s "$(realpath cpu_rec/cpu_rec.py)" /usr/local/bin/cpu_rec.py
}
