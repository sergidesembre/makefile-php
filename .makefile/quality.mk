SHELL = /bin/sh
PHPQA_IMAGE := dev-hub.odigeoconnect.com/alpha/phpqa:master

beautify: PHPQA_ENTRYPOINT = "/tmp/vendor/bin/phpcbf" \
PHPQA_PARAMETERS = "--standard=PSR2 --runtime-set ignore_errors_on_exit 1 --runtime-set ignore_warnings_on_exit 1" \
PHPQA_FOLDERS = $()
ifeq ($(strip $(folders)),)
$(error Folder param is empty)
endif
#ifeq ($(strip $(folders)),)
#	$(error Folder param is empty)
#endif
#	$(MAKE) .phpqa
#	@echo "ooooooooooooooooooooooooooooo"
#	@docker run --rm --entrypoint=/tmp/vendor/bin/phpcbf -w /app -v $(CURDIR):/app -t "$(PHPQA_IMAGE)" -p \
#		--standard=PSR2 \
#		--runtime-set ignore_errors_on_exit 1 \
#		--runtime-set ignore_warnings_on_exit 1 \
#		src tests
#	@docker run --rm --entrypoint=/tmp/vendor/bin/php-cs-fixer -w /app -v $(CURDIR):/app -t "$(PHPQA_IMAGE)" \
#		--rules=@PSR2 \
#		--verbose \
#		--show-progress=dots \
#		fix src

beautify:
	@echo $(PHPQA_ENTRYPOINT)
	@echo $(PHPQA_PARAMETERS)
	@#docker run --rm --entrypoint=/tmp/vendor/bin/php-cs-fixer -w /app -v $(CURDIR):/app -t "$(PHPQA_IMAGE)" \
#		--rules=@PSR2 \
#		--verbose \
#		--show-progress=dots \
#		fix src

.ensure_parameter_not_empty:
ifeq ($(strip $(folders)),)
	$(error Folder param is empty)
endif