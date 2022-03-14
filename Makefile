#######################################################################################################################
#                                                                                                                     #
# Makefile for PHP                                                                                                    #
#                                                                                                                     #
# https://github.com/sergidesembre/makefile-php                                                                       #
# Sergi Desembre <sergi.desembre+github@gmail.com>                                                                    #
#                                                                                                                     #
# DESCRIPTION                                                                                                         #
# This makefiles are created to automate some recurrent task when work with PHP projects. I used GNU make             #
# standards to build (https://www.gnu.org/savannah-checkouts/gnu/make/manual/).                                       #
#                                                                                                                     #
# REQUIREMENTS                                                                                                        #
# This makefile use dotenv file to load required env variables:                                                       #
# - MK_PHP_IMAGE                                                                                                      #
# - MK_DOCKER_COMPOSE_FILE                                                                                            #
#                                                                                                                     #
#######################################################################################################################

SHELL = /bin/sh
MAKEFILE_DIR := $(CURDIR)/.makefile
DOTENV_FILE ?= .env

ifeq ("$(wildcard $(CURDIR)/$(DOTENV_FILE))","")
DOTENV_FILE := .env.dist
endif

## --- DOCKER
.PHONY : start
start: DOCKER_COMPOSE_ACTION = start docker_file=$(MK_DOCKER_COMPOSE_FILE)

.PHONY : stop
stop: DOCKER_COMPOSE_ACTION = stop

## --- DEPENDENCIES
.PHONY : deps/install
deps/install: COMPOSER_ACTION = install

.PHONY : deps/update
deps/update: COMPOSER_ACTION = update

.PHONY : deps/add
deps/add: COMPOSER_ACTION = require package=$(package)

## --- QUALITY
quality: DOCKER_COMPOSE_ACTION = exec image=$(MK_PHP_IMAGE) command=quality

## --- OTHERS
clear: COMPOSER_ACTION = remove

start stop tests tests/unit tests/functional tests/integration tests/e2e quality:
	@$(MAKE) --directory $(MAKEFILE_DIR) -f docker-compose.mk $(DOCKER_COMPOSE_ACTION)

deps/install deps/update deps/add clear:
	@$(MAKE) --directory $(MAKEFILE_DIR) -f composer.mk $(COMPOSER_ACTION)

include $(CURDIR)/$(DOTENV_FILE)