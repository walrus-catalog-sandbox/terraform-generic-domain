locals {
  result = format("%s.%s", coalesce(local.result_contextual, local.result_timestamp, local.result_random), local.domain_suffix)
}

#
# Orchestration
#

output "context" {
  description = "The input context, a map, which is used for orchestration."
  value       = var.context
}

output "refer" {
  description = "The refer, a map, which is used for dependencies or collaborations."
  sensitive   = true
  value = {
    schema = "generic:domain"
    params = {
      selector = {}
      mode     = var.mode
      result   = local.result
    }
  }
}

#
# Reference
#

output "result" {
  description = "The generated result of the domain."
  value       = local.result
}
