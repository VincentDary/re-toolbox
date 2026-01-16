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

DOCKER_IMG_NAME := re-toolbox
DOCKER_CONTAINER_NAME := $(DOCKER_IMG_NAME)
USER := dev

connect:
	docker exec -u $(USER) -it $(DOCKER_CONTAINER_NAME) bash

connect_as_root:
	docker exec -u root -it $(DOCKER_CONTAINER_NAME) bash

clean_docker:
	docker stop $(DOCKER_CONTAINER_NAME)
	docker rm $(DOCKER_CONTAINER_NAME)
	docker image rm $(DOCKER_IMG_NAME)
