FILEEXT :=

ifeq ($(OS),Windows_NT)
	OS_NAME += windows
	RELEASEDIR := build/windows/runner/Release
	FILEEXT := .exe
	DLEXT := dll
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OS_NAME += linux
		RELEASEDIR := build/linux/$(ARCH)/release/bundle
		DLEXT := so
	endif
	ifeq ($(UNAME_S),Darwin)
		OS_NAME += macos
		RELEASEDIR := build/macos/Build/Products/Release
		DLEXT := dylib
	endif
endif

.ONESHELL:
SHELL := $(shell which bash)

GOLIB := go_lib
LIBS := $(GOLIB)/build/lib/libgreet.h $(GOLIB)/build/lib/libgreet.$(DLEXT)

BINTGT = $(RELEASEDIR)/rcinstaller$(FILEEXT)

$(info OS==$(OS_NAME))
$(info RELEASEDIR==$(RELEASEDIR))

.PHONY: all
all: deps $(BINTGT)

.PHONY: deps
deps:
	flutter pub get

$(BINTGT): $(LIBS)
	@echo "build $@";
	flutter build $(OS_NAME)

$(GOLIB)/build/lib/libgreet.%:
	$(info Creating $@)
	$(MAKE) -C $(GOLIB)

.PHONY: clean
clean:
	$(MAKE) -C $(GOLIB)