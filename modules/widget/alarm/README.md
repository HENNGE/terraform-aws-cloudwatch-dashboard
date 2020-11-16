# terraform-aws-cloudwatch-dashboard/modules/widget/alarm

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
| alarms | An array of alarm ARNs to include in the widget. The array can have 1-100 ARNs. | `list(string)` | n/a | yes |
| height | The height of the widget in grid units. The default is 6. Valid Values: 1–1000. | `number` | `null` | no |
| sortBy | Specifies how to sort the alarms in the widget. Valid Values: `default` \| `stateUpdatedTimestamp` \| `timestamp`. | `string` | `null` | no |
| states | Use this field to filter the list of alarms displayed in the widget to only those alarms currently in the specified states. You can specify one or more alarm states in the value for this field. The alarm states that you can specify are `ALARM`, `INSUFFICIENT_DATA`, and `OK`. If you omit this field or specify an empty array, all the alarms specifed in `alarms` are displayed. | `list(string)` | `null` | no |
| title | The title text to be displayed by the widget. | `string` | `null` | no |
| width | The width of the widget in grid units (in a 24-column grid). The default is 6. Valid Values: 1–24. | `number` | `null` | no |
| x | The horizontal position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: 0–23. | `number` | `null` | no |
| y | The vertical position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: Any integer, 0 or higher. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| widget\_json | Widget JSON object (string) |
| widget\_object | Widget Terraform object (map) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
