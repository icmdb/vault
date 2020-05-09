# valut - hashicorp

## Quick Start

```
# Clone Repo
mkdir -p vault && vault
cat > docker-compose.yml <<EOT
version: "3"
services:
  vault-server:
    image: icmdb/vault
    environment:
      - VAULT_ADDR=http://127.0.0.1:8200
    ports:
      - 8200:8200
      - 8201:8201
    command: ["/go/bin/vault", "server", "-dev", "-dev-listen-address=0.0.0.0:8200"]
    restart: always

  vault-agent:
    image: icmdb/vault
    environment:
      - VAULT_AGENT_ADDR=http://vault-server:8200
      - VAULT_LOG_LEVEL=debug
    ports:
      - 8200:8200
    command: ["/go/bin/vault", "agent", "-config=agent.hcl"]
    restart: always
EOT

# Pull images
docker-compose pull

# Start
docker-compose up -d 

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
