SHELL = /bin/sh
.DEFAULT_GOAL = help

.PHONY : help
help:
	@echo "\033[33m start: \033[39m Up docker project."
	@echo "\033[33m stop: \033[39m Down docker project and remove local volumes."

.PHONY : start
start:
	@docker-compose -f $(CURDIR)/../$(docker_file) pull
	@docker-compose -f $(CURDIR)/../$(docker_file) up --build -d
	@echo "\033[36m   Project started <$(docker_file)> \033[39m"

.PHONY : exec
exec:
	@echo "\033[36m   Executing command <$(command)> from image <$(image)>... \033[39m"
	@docker-compose exec -it $(image) $(command)

.PHONY : stop
stop:
	@docker-compose down --remove-orphans -v --rmi local
	@echo "\033[36m   Project stopped \033[39m"