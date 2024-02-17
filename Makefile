help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; { printf("\033[36m%-30s\033[0m %s\n", $$1, $$2) }'

package: build ## Packager l'application dans un fichier .zip
	cd $(BUILD) && zip --quiet --recurse-paths $(APP_NAME).zip $(APP_DIR)

build: ## Construire l'application
	mkdir --parents $(BUILD_APP)/src $(BUILD_APP)/lib $(BUILD_APP)/bin
	cp --update --recursive src lib bin $(BUILD_APP)

install: .check-install-dir ## Installer le package de l'application
	unzip -q -d $(DEST_DIR) $(BUILD)/$(APP_NAME).zip

test: ## Tester l'application localement
	./bin/$(STARTER_APP).sh

test-from-java: ## Tester l'application localement (en lançant le fichier .java)
	./src/$(STARTER_APP).java

test-install: .check-install-dir ## Tester l'application installée
	PATH=$(DEST_DIR)/$(APP_DIR)/bin:$(PATH) $(STARTER_APP).sh

clean: ## Nettoyer le répertoire de build
	rm --force --recursive $(BUILD)

.check-install-dir:
	@test -n '$(DEST_DIR)' || { \
		echo "You need to specify an installation directory and an application name, for example 'DEST_DIR=~ APP_NAME=MyCmdLine make install'"; \
		exit 1; \
	}

.PHONY: build

APP_NAME := $(or $(APP_NAME), BasicQuickstart)
APP_DIR = $(APP_NAME)
BUILD = build
STARTER_APP = Application
BUILD_APP = $(BUILD)/$(APP_DIR)
