# valut - hashicorp

## Quick Start

```
# Clone Repo
git clone https://github.com/icmdb/vault.git

# Enter Directory
cd vault

# Pull images
docker-compose pull

# Start
docker-compose up -d vault-server vault-agent

# Remove (Carefully)
docker-compose down
```

### Build 

> Build binary for your current arch

```
make build

# Or (for China Mainland)
make cnbuild 

# Copy Binary to valut-${GOOS}
make run
```

## Reference

* [Download Vault](https://www.vaultproject.io/downloads.html)
* [Libraries - Vault](https://www.vaultproject.io/api/libraries.html)

## Todo List

* [x] Build
    * [x] Linux
    * [x] MacOS
    * [x] Windows (not tested yet)
* [ ] Demo
    * [ ] Server
    * [ ] Agent
    * [ ] Config
* [ ] Libararies Example
    * [ ] Python
    * [ ] Scala
    * [ ] Elixir
    * [ ] Golang

```
docker build --build-arg GOOS=$(uname|tr A-Z a-z) --build-arg VAULT_VERSION=1.2.3 -t vault:1.2.3-$(uname|tr A-Z a-z) .
```
