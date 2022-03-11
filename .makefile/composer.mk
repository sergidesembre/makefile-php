SHELL = /bin/sh
COMPOSER_OPTIONS =

ifneq (,$(findstring i, $(MAKEFLAGS)))
COMPOSER_OPTIONS += "--ignore-platform-reqs"
endif

install: DEPS_ACTION = install $(COMPOSER_OPTIONS)
update: DEPS_ACTION = update $(COMPOSER_OPTIONS)
require: DEPS_ACTION = require $(package) $(COMPOSER_OPTIONS)
remove: DEPS_ACTION = rm -rf vendor composer.lock

install update require remove:
	@docker run \
		--rm --volume $(CURDIR)/..:/app \
		--user $(id -u):$(id -g) \
		composer:latest $(DEPS_ACTION) $(COMPOSER_OPTIONS)
	@echo "\033[36m   Completed dependencies execution <$(DEPS_ACTION)> \033[39m"