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

FROM debian:bookworm-20231009

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y locales

RUN echo "C.UTF-8 en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen C.UTF-8
RUN dpkg-reconfigure locales

ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN useradd -m -d /home/toolbox -s /bin/bash -c "toolbox user" -U toolbox
RUN usermod -L toolbox
RUN echo "toolbox ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir /opt/data
RUN chown -R toolbox: /opt/data

WORKDIR /opt/

ADD install_files /opt/install_files
RUN chown -R toolbox: /opt/install_files
ADD /install_scripts /opt/install_scripts
RUN chown -R toolbox: /opt/install_scripts
RUN chmod u+x /opt/install_scripts/*.sh
RUN /opt/install_scripts/install.sh

WORKDIR /opt/data
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
