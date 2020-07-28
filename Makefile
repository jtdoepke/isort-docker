NAME=alphachai/isort:devel
CMD=run -it --rm --mount type=bind,src=$$(pwd),dst=/app $(NAME)

-include $(shell [ -e .build-harness ] || curl -sSL -o .build-harness "https://git.io/mintel-build-harness"; echo .build-harness)

.PHONY: init build shell clean isort isort/check

init: bh/init

build:
	$(DOCKER) build -f $(DOCKER_FILE) -t $(NAME) .

isort:
	$(DOCKER) $(CMD) $(ISORT_FLAGS) $(PYTHON_LINT_TARGETS)

isort/check:
	$(DOCKER) $(CMD) $(ISORT_FLAGS) --check-only $(PYTHON_LINT_TARGETS) --diff

shell:
	$(DOCKER) run -it --rm --entrypoint sh $(NAME)

clean: bh/clean
