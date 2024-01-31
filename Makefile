package: build
	cd $(BUILD) && zip --recurse-paths $(APP_NAME).zip $(APP_DIR)

build: clean
	mkdir --parents $(BUILD_APP)/src/{fr,en} $(BUILD_APP)/lib $(BUILD_APP)/bin
	cp --recursive src lib bin $(BUILD_APP)

install: .check-install-dir
	unzip -d $(PREFIX) $(BUILD)/$(APP_NAME).zip

clean:
	rm --force --recursive $(BUILD)

test:
	APP_DIR=. ./src/$(APP_NAME).java

test-install: .check-install-dir
	PATH=$(PREFIX)/$(APP_DIR)/bin:$(PATH) $(APP_NAME).sh

.check-install-dir:
	@test -n '$(PREFIX)' || { \
		echo "You need to specify an installation directory, for example 'PREFIX=~ make install'"; \
		exit 1; \
	}

APP_NAME := $(or $(APP_NAME), "BasicQuickstart")
APP_DIR=$(APP_NAME)
BUILD=build
BUILD_APP=$(BUILD)/$(APP_DIR)
