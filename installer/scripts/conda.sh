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
  CONDA_BIN=/opt/conda/bin/conda

  curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc \
    | gpg --dearmor > conda.gpg

  install -o root -g root -m 644 conda.gpg /usr/share/keyrings/conda-archive-keyring.gpg

  rm -f conda.gpg

  gpg --keyring /usr/share/keyrings/conda-archive-keyring.gpg \
      --no-default-keyring  \
      --fingerprint 34161F5BF5EB1D4BFBBB8F0A8AEB4F8B29D82806

  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/conda-archive-keyring.gpg] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" \
      > /etc/apt/sources.list.d/conda.list

  apt-get update
  apt-get install --yes conda

  sudo -u "${USER}" ${CONDA_BIN} init
  sudo -u "${USER}" ${CONDA_BIN} config --set auto_activate_base false
  sudo -u "${USER}" ${CONDA_BIN} config --add channels conda-forge
  sudo -u "${USER}" ${CONDA_BIN} config --remove channels defaults
  sudo -u "${USER}" ${CONDA_BIN} config --show channels
  sudo -u "${USER}" ${CONDA_BIN} info
}