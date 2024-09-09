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

USER := root
DKR_IMG_NAME := re-toolbox
DKR_CONT_NAME := $(DKR_IMG_NAME)

.PHONY:

build:
	docker build --no-cache --progress plain -t $(DKR_IMG_NAME) .

instance:
	docker-compose up -d

stop:
	docker stop $(DKR_IMG_NAME)

clean:
	docker stop $(DKR_IMG_NAME)
	docker rm $(DKR_IMG_NAME)
	docker image rm $(DKR_IMG_NAME)

connect:
	docker exec -u $(USER) -it $(DKR_CONT_NAME) bash
