COMPOSE_FILE := srcs/docker-compose.yml
ENV_FILE := srcs/.env
DATA_DIR := $(HOME)/data
WP_DIR := $(DATA_DIR)/www-data
DB_DIR := $(DATA_DIR)/db-data
MAILHOG_DIR := $(DATA_DIR)/mailhog-data

all: set_up_volumes up

set_up_volumes:
	@echo "Creating data directories"
	@mkdir -p $(DATA_DIR)
	@mkdir -p $(WP_DIR)
	@mkdir -p $(DB_DIR)
	@mkdir -p $(MAILHOG_DIR)

build:
	@echo "Building Docker Images"
	docker compose -f $(COMPOSE_FILE) build
	@echo "Buld completed!"

up:
	@echo "Starting services"
	docker compose -f $(COMPOSE_FILE) up -d --build
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
	docker system prune -a -f
	@sudo rm -rf $(WP_DIR)/
	@sudo rm -rf $(DB_DIR)/
	@sudo rm -rf $(MAILHOG_DIR)/

ps:
	docker compose -f $(COMPOSE_FILE) ps

fclean: clean
	docker system prune -a --volumes -f
	docker network prune --force
	docker volume prune --force

re: fclean all

.PHONY: all set_up_volumes build up stop down clean ps fclean re