DOCKER_COMPOSE_DIR=./.docker
DOCKER_COMPOSE_FILE=$(DOCKER_COMPOSE_DIR)/docker-compose.yml
DEFAULT_CONTAINER=hub
DOCKER_COMPOSE=docker-compose -f $(DOCKER_COMPOSE_FILE) --project-directory $(DOCKER_COMPOSE_DIR)

ifeq ($(user),)
# USER retrieved from, UID from shell.
HOST_USER ?= $(strip $(if $(USER),$(USER),nodummy))
else
# allow override by adding user= and/ or uid=  (lowercase!).
# uid= defaults to 0 if user= set (i.e. root).
HOST_USER = $(user)
endif
export HOST_USER

PROJECT_NAME = $(notdir $(PWD))
export PROJECT_NAME

DEFAULT_GOAL := help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ [Docker] Build / Infrastructure
.docker/:
	cp $(DOCKER_COMPOSE_DIR)/.example $(DOCKER_COMPOSE_DIR)/

make-test: ## Test the build itself
	@echo $(PROJECT_NAME)
	@echo $(HOST_USER)

.PHONY: 
: .docker/ ## Make sure the  file exists for docker

.PHONY: docker-up
docker-up:  ## Start all docker containers. To only start one container, use CONTAINER=<service>
	$(DOCKER_COMPOSE) up -d $(CONTAINER)

.PHONY: docker-build
docker-build:  ## Build all docker images. Build a specific image by providing the service name via: make docker-build CONTAINER=<service>
	$(DOCKER_COMPOSE) build --parallel $(CONTAINER) && \
	$(DOCKER_COMPOSE) up -d --force-recreate $(CONTAINER)

.PHONY: docker-build-from-scratch
docker-build-from-scratch:  ## Build all docker images from scratch, without cache etc. Build a specific image by providing the service name via: make docker-build CONTAINER=<service>
	$(DOCKER_COMPOSE) rm -fs $(CONTAINER) && \
	$(DOCKER_COMPOSE) build --pull --no-cache --parallel $(CONTAINER) && \
	$(DOCKER_COMPOSE) up -d --force-recreate $(CONTAINER)

.PHONY: docker-test
docker-test:  docker-up ## Run the infrastructure tests for the docker setup
	sh $(DOCKER_COMPOSE_DIR)/docker-test.sh


.PHONY: docker-down
docker-down:  ## Stop and remove all docker containers. To only stop and remove one container, use CONTAINER=<service>
	$(DOCKER_COMPOSE) down $(CONTAINER)

.PHONY: docker-clean
docker-clean: ## Remove created containers and images
	$(DOCKER_COMPOSE) down --remove-orphans --rmi all
	$(DOCKER_COMPOSE) rm -fs $(CONTAINER)

.PHONY: docker-prune
docker-prune: ## Remove unused docker resources via 'docker system prune -a -f --volumes'
	docker system prune -a -f --volumes
