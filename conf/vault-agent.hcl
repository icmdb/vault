vault {
  address = "http://127.0.0.1:8200"
}

auto_auth {
  method "aws" {
    config = {
      type = "iam"
      role = "eng-infra"
    }
  }
  sink {
    type = "file"
    config = {
      path = "/Users/youqing/.vault-token"
    }
  }
}

cache {
  use_auto_auth_token = true
}

listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = true
}
