APP_NAME=BasicQuickstart
APP_DIR=basic-quickstart

BUILD=build
BUILD_APP=$(BUILD)/$(APP_DIR)

test:
	APP_DIR=. ./src/$(APP_NAME).java

package: build
	cd $(BUILD) && zip --recurse-paths $(APP_NAME).zip $(APP_DIR)

install: check-install-dir
	unzip -d $(PREFIX) $(BUILD)/$(APP_NAME).zip

test-install: check-install-dir
	PATH=$(PREFIX)/$(APP_DIR)/bin:$(PATH) $(APP_NAME).sh

check-install-dir:
	@test -n '$(PREFIX)' || { echo "You need to specify an installation directory, for example 'PREFIX=~ make install'"; exit 1; }

build: prepare
	cp --recursive src $(BUILD_APP)
	cp --recursive lib $(BUILD_APP)
	cp bin/* $(BUILD_APP)/bin

prepare: clean
	mkdir --parents \
		$(BUILD_APP)/src $(BUILD_APP)/src/fr $(BUILD_APP)/src/en \
		$(BUILD_APP)/lib \
		$(BUILD_APP)/bin

clean:
	rm --force --recursive $(BUILD)
