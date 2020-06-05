default: scalingo scalingo-18

VERSION := 5.2.1
ROOT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

clean:
	rm -rf src/ dist/

# Download missing source archives to ./src/
src/jemalloc-%.tar.bz2:
	mkdir -p $$(dirname $@)
	curl -fsL https://github.com/jemalloc/jemalloc/releases/download/$*/jemalloc-$*.tar.bz2 -o $@

.PHONY: scalingo scalingo-18

# Build for scalingo stack
scalingo: src/jemalloc-$(VERSION).tar.bz2
	docker run --rm -it --volume="$(ROOT_DIR):/wrk" \
		scalingo/builder:v25 /wrk/build.sh $(VERSION) scalingo

# Build for scalingo-18 stack
scalingo-18: src/jemalloc-$(VERSION).tar.bz2
	docker run --rm -it --volume="$(ROOT_DIR):/wrk" \
		scalingo/builder-18:v1 /wrk/build.sh $(VERSION) scalingo-18

# Build recent releases for all supported stacks
all:
	$(MAKE) scalingo scalingo-18 VERSION=3.6.0
	$(MAKE) scalingo scalingo-18 VERSION=4.0.4
	$(MAKE) scalingo scalingo-18 VERSION=4.1.1
	$(MAKE) scalingo scalingo-18 VERSION=4.2.1
	$(MAKE) scalingo scalingo-18 VERSION=4.3.1
	$(MAKE) scalingo scalingo-18 VERSION=4.4.0
	$(MAKE) scalingo scalingo-18 VERSION=4.5.0
	$(MAKE) scalingo scalingo-18 VERSION=5.0.1
	$(MAKE) scalingo scalingo-18 VERSION=5.1.0
	$(MAKE) scalingo scalingo-18 VERSION=5.2.0
	$(MAKE) scalingo scalingo-18 VERSION=5.2.1
