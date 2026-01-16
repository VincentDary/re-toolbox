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
  'cpu_rec::git+https://github.com/airbus-seclab/cpu_rec.git@6b192399cd56ad6953e568e1263024dd8a4ef38d'
)

run_install()
{
  mv cpu_rec "${INSTALL_TOOLS_DIR}/airbus_seclab_cpu_rec"

  WRAPPER_BIN="${INSTALL_BIN_DIR}/cpu_rec"

  {
    echo "#!/usr/bin/env bash"
    echo 'SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )'
    echo 'python "${SCRIPT_DIR}/../tools/airbus_seclab_cpu_rec/cpu_rec.py"'
  } >> "${WRAPPER_BIN}"

  chmod ugo=rwx "${WRAPPER_BIN}"
}
