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

post_install_config()
{
  # Ghidra post config
  ghidra_dir=$(dirname "$(readlink -f /usr/bin/ghidra)")
  cp -r /opt/bindiff/extra/ghidra/BinExport "${ghidra_dir}/Extensions/Ghidra/"
}
