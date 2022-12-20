define target_success
	@printf "\033[32m==> Target \"$(1)\" passed\033[0m\n\n"
endef

.DEFAULT_GOAL := help

TARGET: ## DESCRIPTION
	@echo "TARGET is here only to provide the header for 'help'"

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

install-requirements: ## Install all requirements
	pip3 install -q -r requirements.txt --no-cache-dir
	$(call target_success,$@)

pre-push: test ## Run pre-push tests
	$(call target_success,$@)

test: install-requirements ## Run tests
	$(call target_success,$@)

clean: clean-pyc ## Remove all artifacts
	$(call target_success,$@)

clean-pyc: ## Remove Python artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '.eggs' -exec rm -rf {} +
	rm -fr dist/
	rm -fr build/
