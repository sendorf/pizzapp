.DEFAULT_GOAL:=help
SHELL:=/bin/bash

.PHONY: help clean_db install start test_setup test make

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

clean_db: ## Drops the current data base and creates it from scratch
	$(info Creating DataBase)
	@docker-compose run --rm pizzapp bundle exec rake db:drop db:create db:migrate

install:  ## Checks and installs dependencies
	$(info Checking and getting dependencies)
	@docker-compose run --rm pizzapp bash -c "bundle check || bundle install"

start: ## Starts the development server
	$(info Starting the development server)
	@docker-compose run --rm --service-ports pizzapp bundle exec rails s -b 0.0.0.0

test_setup: install ## Setup the test environment
	$(info Setting up the test environment)
	@docker-compose run --rm pizzapp bash -c "RAILS_ENV=test rake db:drop db:create && RAILS_ENV=test rake environment db:schema:load"

test: ## Starts the test runner
	$(info Running tests)
	@docker-compose run --rm pizzapp bundle exec rspec --format documentation
