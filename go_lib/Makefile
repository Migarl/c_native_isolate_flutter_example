ifeq ($(OS),Windows_NT)
	LIBEXT := .dll
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		LIBEXT := .so
		LDFLAGS_EXTRA := --verbose
	endif
	ifeq ($(UNAME_S),Darwin)
		LIBEXT := .dylib
	endif
endif

.ONESHELL:
SHELL := $(shell which bash)

GOOS ?= linux
GOARCH ?= amd64
BUILDDIR = $(CURDIR)/build/lib

.PHONY: all
all: $(BUILDDIR)/libgreet$(LIBEXT)

$(BUILDDIR)/libgreet$(LIBEXT): main.go
	@echo "build $@";
	go build -o $(BUILDDIR)/libgreet$(LIBEXT) -buildmode=c-shared main.go;

.PHONY: clean
clean:
	rm -r $(BUILDDIR)