NAME = tobiasbp/openldap-fusiondirectory
VERSION = 0.0.2

.PHONY: all build build-nocache

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

build-nocache:
	docker build -t $(NAME):$(VERSION) --no-cache --rm .
