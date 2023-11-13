output "context" {
  description = "The input context, a map, which is used for orchestration."
  value       = var.context
}

output "selector" {
  description = "The selector, a map, which is used for dependencies or collaborations."
  value       = local.tags
}

output "result" {
  description = "The generated result of the domain."
  value       = format("%s.%s", coalesce(local.result_contextual, local.result_timestamp, local.result_random), local.domain_suffix)
}
