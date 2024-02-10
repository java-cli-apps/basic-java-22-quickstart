help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

package: build ## Packager l'application dans un fichier .zip
	cd $(BUILD) && zip --recurse-paths $(APP_NAME).zip $(APP_DIR)

build: clean ## Construire l'application
	mkdir --parents $(BUILD_APP)/src $(BUILD_APP)/lib $(BUILD_APP)/bin
	cp --recursive src lib bin $(BUILD_APP)

install: .check-install-dir ## Installer le package de l'application
	unzip -d $(PREFIX) $(BUILD)/$(APP_NAME).zip

test: ## Tester l'application localement
	./bin/$(STARTER_APP).sh

test-from-java: ## Tester l'application localement en lançant le fichier .java
	APP_DIR=. ./src/$(STARTER_APP).java

test-install: .check-install-dir ## Tester l'application installée
	PATH=$(PREFIX)/$(APP_DIR)/bin:$(PATH) $(STARTER_APP).sh

clean: ## Nettoyer le répertoire de build
	rm --force --recursive $(BUILD)

.check-install-dir:
	@test -n '$(PREFIX)' || { \
		echo "You need to specify an installation directory, for example 'PREFIX=~ make install'"; \
		exit 1; \
	}

APP_NAME := $(or $(APP_NAME), "BasicQuickstart")

APP_DIR = $(APP_NAME)
BUILD = build
STARTER_APP = Application
BUILD_APP = $(BUILD)/$(APP_DIR)
