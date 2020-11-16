# terraform-aws-cloudwatch-dashboard/modules/widget/log

Creates Log Widget in Cloudwatch Dashboard.

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
| query | Contains the CloudWatch Logs Insights query function. The query string starts with the names of the log groups that are to be queried. You must pre-pend each log group name with SOURCE. Separate multiple log groups with a pipe character (\|). Add another pipe character after the list of log groups, and then specify the query syntax. Separate each line in the query syntax with \n\|. [More Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Log-Widget-Object) | `string` | n/a | yes |
| region | The Region of the logs query. | `string` | n/a | yes |
| title | The title text to be displayed by the widget. | `string` | `null` | no |
| view | Specifies how the query results are displayed. Specify `table` to view the results as a table. Specify `timeSeries` to display this metric as a line graph. Specify `bar` to display it as a bar graph. Specify `pie` to display it as a pie graph. If you omit this parameter, the results are displayed as a table. | `string` | `null` | no |
| width | The width of the widget in grid units (in a 24-column grid). The default is 6. Valid Values: 1–24. | `number` | `null` | no |
| x | The horizontal position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: 0–23. | `number` | `null` | no |
| y | The vertical position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: Any integer, 0 or higher. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| widget\_json | Widget JSON object (string) |
| widget\_object | Widget Terraform object (map) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
