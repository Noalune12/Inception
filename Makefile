COMPOSE_FILE = srcs/docker-compose.yml
# PROJECT_NAME = inception
# ALPINE_VERSION = 3.21

all: build up

# watch: build
# 	docker compose -f $(COMPOSE_FILE) up --watch

# nowatch:
# 	docker compose -f $(COMPOSE_FILE) down

build:
	@echo "Building Docker Images"
	docker compose -f $(COMPOSE_FILE) build
	@echo "Buld completed!"

up:
	@echo "Starting services"
	docker compose -f $(COMPOSE_FILE) up -d
	@echo "Services started!"

stop:
	@echo "Stopping services"
	docker compose -f $(COMPOSE_FILE) stop
	@echo "Services stopped!"

down:
	@echo "Downing services"
	docker compose -f $(COMPOSE_FILE) down
	@echo "Services downed!"

clean:
	docker compose -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans
	docker system prune -f

ps:
	docker compose -f $(COMPOSE_FILE) ps

prune:
	docker system prune -a --volumes

.PHONY: all build up stop down clean ps prune