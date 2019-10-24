.PHONY: build image clean test

GOOS=$(shell uname | tr A-Z a-z)
MIRROR=https://mirrors.aliyun.com
GOPROXY=https://mirrors.aliyun.com/goproxy/

OPTS=help all build cnbuild clean

help:
	@echo "make [SUBCOMMAND]"
	@for opt in $(OPTS); do echo "\t"$$opt; done

all: build run

build:
	docker-compose build vault-${GOOS}

cnbuild:
	docker-compose build --build-arg GOOS=${GOOS} --build-arg MIRROR=${MIRROR} --build-arg GOPROXY=${GOPROXY} vault-${GOOS}
		
run: 
	docker-compose run --rm vault-$(GOOS)

clean:
	rm -rf ./vault-linux/
	rm -rf ./vault-darwin/
	rm -rf ./vault-windows/

