#
# Contextual Fields
#

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}

#
# Infrastructure Fields
#

variable "infrastructure" {
  description = <<-EOF
Specify the infrastructure information for deploying.

Examples:
```
infrastructure:
  type: string, optional
```
EOF
  type = object({
    domain_suffix = optional(string, "example.io")
  })
  default = {}
}

#
# Deployment Fields
#

variable "deployment" {
  description = <<-EOF
Specify the deployment action.

Examples:
```
deployment:
  type: string, optional         # i.e. contextual, timestamp, random
```
EOF
  type = object({
    type = optional(string, "contextual")
  })
  default = {
    type = "contextual"
  }
}
