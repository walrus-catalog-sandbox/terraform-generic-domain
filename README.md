# Generic Domain(Name) Service

Terraform module generates the domain by the given domain suffix, intended for use with a [Wildcard DNS record](https://en.wikipedia.org/wiki/Wildcard_DNS_record).

## Usage

```hcl
module "example" {
  source = "..."

  infrastructure = {
    domain_suffix = "..."
  }

  deployment = {
    type = contextual
  }
}

```

## Examples

- [Contextual](./examples/contextual)
- [Random](./examples/random)
- [Timestamp](./examples/timestamp)

## Contributing

Please read our [contributing guide](./docs/CONTRIBUTING.md) if you're interested in contributing to Walrus template.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.9.1 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_integer.indexer](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [time_static.current](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_context"></a> [context](#input\_context) | Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.<br><br>Examples:<pre>context:<br>  project:<br>    name: string<br>    id: string<br>  environment:<br>    name: string<br>    id: string<br>  resource:<br>    name: string<br>    id: string</pre> | `map(any)` | `{}` | no |
| <a name="input_infrastructure"></a> [infrastructure](#input\_infrastructure) | Specify the infrastructure information for deploying.<br><br>Examples:<pre>infrastructure:<br>  type: string, optional</pre> | <pre>object({<br>    domain_suffix = optional(string, "example.io")<br>  })</pre> | `{}` | no |
| <a name="input_deployment"></a> [deployment](#input\_deployment) | Specify the deployment action, like scaling, scheduling, security and so on.<br><br>Examples:<pre>deployment:<br>  type: string, optional         # i.e. contextual, timestamp, hashed</pre> | <pre>object({<br>    type = optional(string, "contextual")<br>  })</pre> | <pre>{<br>  "type": "contextual"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_context"></a> [context](#output\_context) | The input context, a map, which is used for orchestration. |
| <a name="output_selector"></a> [selector](#output\_selector) | The selector, a map, which is used for dependencies or collaborations. |
| <a name="output_result"></a> [result](#output\_result) | The generated result of the domain. |
<!-- END_TF_DOCS -->

## License

Copyright (c) 2023 [Seal, Inc.](https://seal.io)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [LICENSE](./LICENSE) file for details.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
