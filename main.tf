locals {
  project_name     = coalesce(try(var.context["project"]["name"], null), "default")
  project_id       = coalesce(try(var.context["project"]["id"], null), "default_id")
  environment_name = coalesce(try(var.context["environment"]["name"], null), "test")
  environment_id   = coalesce(try(var.context["environment"]["id"], null), "test_id")
  resource_name    = coalesce(try(var.context["resource"]["name"], null), "example")
  resource_id      = coalesce(try(var.context["resource"]["id"], null), "example_id")

  domain_suffix = coalesce(var.infrastructure.domain_suffix, "example.io")
  namespace     = join("-", [local.project_name, local.environment_name])
  tags = {
    "walrus.seal.io/project-id"       = local.project_id
    "walrus.seal.io/environment-id"   = local.environment_id
    "walrus.seal.io/resource-id"      = local.resource_id
    "walrus.seal.io/project-name"     = local.project_name
    "walrus.seal.io/environment-name" = local.environment_name
    "walrus.seal.io/resource-name"    = local.resource_name
  }
}

resource "time_static" "current" {
  count = var.deployment.type != "contextual" ? 1 : 0
}

resource "random_integer" "indexer" {
  count = var.deployment.type == "random" ? 1 : 0

  min = 10
  max = 64 - 10
}

locals {
  result_contextual = var.deployment.type == "contextual" ? format("%s.%s", local.resource_name, local.namespace) : null
  result_timestamp  = var.deployment.type == "timestamp" ? format("%s-%d", local.resource_name, time_static.current[0].unix) : null
  result_random     = var.deployment.type == "random" ? format("%s-%s", local.resource_name, substr(sha256(join("-", [local.namespace, time_static.current[0].rfc3339])), random_integer.indexer[0].result, 10)) : null
}
