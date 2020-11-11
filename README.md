# terraform-aws-cloudwatch-dashboard

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| end | The end of the time range to use for each widget on the dashboard when the dashboard loads. If you specify a value for `end`, you must also specify a value for `start`. For each of these values, specify an absolute time in the ISO 8601 format. For example, `2018-12-17T06:00:00.000Z`. | `string` | `null` | no |
| name | Name of the dashboard. | `any` | n/a | yes |
| periodOverride | Use this field to specify the period for the graphs when the dashboard loads. Specifying auto causes the period of all graphs on the dashboard to automatically adapt to the time range of the dashboard. Specifying inherit ensures that the period set for each graph is always obeyed. Valid Values: auto \| inherit. | `string` | `null` | no |
| start | The start of the time range to use for each widget on the dashboard. You can specify `start` without specifying `end` to specify a relative time range that ends with the current time. In this case, the value of start must begin with `-PT` if you specify a time range in minutes or hours, and must begin with `-P` if you specify a time range in days, weeks, or months. You can then use M, H, D, W and M as abbreviations for minutes, hours, days, weeks and months. For example, `-PT5M` shows the last 5 minutes, `-PT8H` shows the last 8 hours, and `-P3M` shows the last three months. You can also use `start` along with an `end` field, to specify an absolute time range. When specifying an absolute time range, use the ISO 8601 format. For example, `2018-12-17T06:00:00.000Z`. If you omit `start`, the dashboard shows the default time range when it loads. | `string` | `null` | no |
| widgets | List of Widget object (obtained from modules/widget, terraform object) to attach to this dashboard. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| dashboard\_arn | The Amazon Resource Name (ARN) of the dashboard. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
