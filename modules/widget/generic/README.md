# terraform-aws-cloudwatch-dashboard/modules/widget/generic

This module will process input into clean Object and JSON object for Cloudwatch Dashboard Widget.

Use this module if the widget is unsupported.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| height | The height of the widget in grid units. The default is 6. Valid Values: 1–1000. | `number` | `null` | no |
| properties | The detailed properties of the widget, which differ depending on the widget type. | `any` | n/a | yes |
| type | The type of widget. Valid Values: `metric | text | log | alarm`. | `string` | n/a | yes |
| width | The width of the widget in grid units (in a 24-column grid). The default is 6. Valid Values: 1–24. | `number` | `null` | no |
| x | The horizontal position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: 0–23. | `number` | `null` | no |
| y | The vertical position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: Any integer, 0 or higher. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| widget\_json | Widget JSON object (string) |
| widget\_object | Widget Terraform object (map) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
