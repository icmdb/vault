.PHONY: build image clean test

GOOS=$(shell uname | tr A-Z a-z)
MIRROR=https://mirrors.aliyun.com
GOPROXY=https://mirrors.aliyun.com/goproxy/
#GOPROXY=https://goproxy.cn
#GOPROXY=https://goproxy.io,direct

OPTS=help all build cnbuild run up clean

help:
	@echo "make [SUBCOMMAND]"
	@echo "	all		build, up"
	@for opt in $(OPTS); do echo "\t"$$opt; done

all: build up

build:
	docker-compose -f docker-compose-src.yml build vault-${GOOS}

cnbuild:
	docker-compose -f docker-compose-src.yml build --build-arg GOOS=${GOOS} --build-arg MIRROR=${MIRROR} --build-arg GOPROXY=${GOPROXY},direct vault-${GOOS}
		
run: 
	docker-compose -f docker-compose-src.yml run --rm vault-$(GOOS)

up:
	docker-compose up -d server
	docker-compose up -d agent

clean:
#	$(shell docker ps -a | grep Exit |awk '{print $1}' | xargs docker rm)
#	$(shell docker images | grep 'vault\|none'|awk '{print $3}'|xargs docker rmi )
	rm -rf ./vault-linux/
	rm -rf ./vault-darwin/
	rm -rf ./vault-windows/
