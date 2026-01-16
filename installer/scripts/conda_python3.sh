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

run_install()
{
  PYTHON_VERSION="3.9.2"
  CONDA_BIN=/opt/conda/bin/conda
  DEFAULT_DEV_PY_ENV_NAME="toolbox_py_${PYTHON_VERSION//./_}"
  DEFAULT_DEV_PY_ENV_PATH="${INSTALL_TOOLS_DIR}/${DEFAULT_DEV_PY_ENV_NAME}"

  sudo -u "${USER}" bash -c \
    "echo y | ${CONDA_BIN} create --prefix '${DEFAULT_DEV_PY_ENV_PATH}' python==${PYTHON_VERSION}"
}
