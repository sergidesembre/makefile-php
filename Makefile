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

## DOCKER
.PHONY : start
start: DOCKER_TARGET = start docker_file=$(MK_DOCKER_COMPOSE_FILE)

.PHONY : stop
stop: DOCKER_TARGET = stop

start stop:
	@$(MAKE) --directory $(MAKEFILE_DIR) -f docker-compose.mk $(DOCKER_TARGET)

## DEPENDENCIES
.PHONY : deps/install
deps/install: DEPS_TARGET = install

.PHONY : deps/update
deps/update: DEPS_TARGET = update

.PHONY : deps/add
deps/add: DEPS_TARGET = require package=$(package)

deps/install deps/update deps/add:
	@$(MAKE) --directory $(MAKEFILE_DIR) -f composer.mk $(DEPS_TARGET)

include $(CURDIR)/$(DOTENV_FILE)