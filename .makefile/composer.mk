SHELL = /bin/sh
COMPOSER_OPTIONS =

ifneq (,$(findstring i, $(MAKEFLAGS)))
COMPOSER_OPTIONS += "--ignore-platform-reqs"
endif

.PHONY : install
install: DEPS_ACTION = install $(COMPOSER_OPTIONS)

.PHONY : update
update: DEPS_ACTION = update $(COMPOSER_OPTIONS)

.PHONY : require
require: DEPS_ACTION = require $(package) $(COMPOSER_OPTIONS)

.PHONY : remove
remove: DEPS_ACTION = rm -rf vendor composer.lock

install update require remove:
	@docker run \
		--rm --volume $(CURDIR)/..:/app \
		--user $(id -u):$(id -g) \
		composer:latest $(DEPS_ACTION) $(COMPOSER_OPTIONS)
	@echo "\033[36m   Completed dependencies execution <$(DEPS_ACTION)> \033[39m"