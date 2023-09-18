.PHONY: all
all: ## start container
	docker-compose up -d

.PHONY: down
down: ## down container
	docker-compose down

.PHONY: build
build: ##  build container
	docker-compose build

## help target -------------------------

.PHONY: help
help: ## display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: index
index:
	docker-compose up -d -build
	sleep 30
	curl -X PUT "localhost:9200/test"  --header "Content-Type: application/json" -d @"index.json"