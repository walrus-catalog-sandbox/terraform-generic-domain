locals {
  project_name     = coalesce(try(var.context["project"]["name"], null), "default")
  environment_name = coalesce(try(var.context["environment"]["name"], null), "test")
  resource_name    = coalesce(try(var.context["resource"]["name"], null), "example")

  namespace     = join("-", [local.project_name, local.environment_name])
  domain_suffix = coalesce(var.infrastructure.domain_suffix, "example.io")
}

resource "time_static" "current" {
  count = var.mode != "contextual" ? 1 : 0
}

resource "random_integer" "indexer" {
  count = var.mode == "random" ? 1 : 0

  min = 10
  max = 64 - 10
}

locals {
  result_contextual = var.mode == "contextual" ? format("%s.%s", local.resource_name, local.namespace) : null
  result_timestamp  = var.mode == "timestamp" ? format("%s-%d", local.resource_name, time_static.current[0].unix) : null
  result_random     = var.mode == "random" ? format("%s-%s", local.resource_name, substr(sha256(join("-", [local.namespace, time_static.current[0].rfc3339])), random_integer.indexer[0].result, 10)) : null
}
