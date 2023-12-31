terraform {
  required_version = ">= 1.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }
}

module "this" {
  source = "../.."

  context = {
    project = {
      id   = "pid"
      name = "pname"
    }
    environment = {
      id   = "eid"
      name = "ename"
    }
    resource = {
      id   = "rid"
      name = "rname"
    }
  }

  infrastructure = {
    domain_suffix = "example.io"
  }

  mode = "random"
}

output "context" {
  value = module.this.context
}

output "refer" {
  value = nonsensitive(module.this.refer)
}

output "result" {
  value = module.this.result
}
