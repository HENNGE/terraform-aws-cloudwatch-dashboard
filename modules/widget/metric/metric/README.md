# terraform-aws-cloudwatch-dashboard/modules/widget/metric/metric

Terraform helper module to describe metric inside metrics array in metric widget in a more documented way.

Basically AWS wants this kind of format:
`[Namespace, MetricName, [{DimensionName,DimensionValue}...] [Rendering Properties Object] ]`

or

`[ {"expression" : "Expression", ["label" : "label] , ["id" : Id] }]`

in json array form.

This module can be used in 2 different way:
- To generate Metrics Array (First JSON format above)
- To generate Expression in Metrics Array (Second JSON format above)

To generate first JSON, supply `namespace`, `metricName`, `dimensions` and other parameters.

To generate second JSON, supply only `expression`, `label` (optional), and `id` (optional) parameters to the module.

## Example

```hcl
module "metric_widget" {
  source = ".."
  //...other parameters
  metrics = [
    module.dynamodb_table1_metric.metric_properties_object
  ]
}

module "dynamodb_table1_metric" {
  source      = "."
  namespace   = "AWS/DynamoDB"
  metricName  = "ConsumedWriteCapacityUnits"
  dimensions  = {
    TableName = "dynamodb-table-name"
  }
}
```

As we can see from the example, with this helper, the cryptic compact array form is better documented.

Below is an example for more complex use, e.g. you want the widget to show `ConsumedWriteCapacityUnits` from multiple dynamodb tables

```hcl
module "metric_widget" {
  source = ".."
  //...other parameters
  metrics = module.dynamodb_write_metrics[*].metric_properties_object
}

locals  {
  dynamodb_tables = [
    "table1",
    "table2",
    "table3",
    "tableN"
  ]
}

module "dynamodb_write_metrics" {
  source = "."
  count       = length(local.dynamodb_tables)
  namespace   = "AWS/DynamoDB"
  metricName  = "ConsumedWriteCapacityUnits"
  dimensions  = {
    TableName = local.dynamodb_tables[count.index]
  }
}
```

### Example for metrics with multiple dimensions

```hcl
module "target_group_metric" {
  source     = "."
  namespace  = "AWS/ApplicationELB"
  metricName = "RequestCountPerTarget"
  dimensions = {
    TargetGroup   = "targetgroup/hoge-tg/abcdef1234567890"
    LoadBalancer  = "app/hoge-alb/0123456789abcdef"
  }
  label      = "Set a custom label"
}
```

### Example with expression metric

```hcl
module "expression" {
  source     = "."
  expression = "SUM(METRICS())"
  label      = "Expression label"
}
```

this module will produce `[ {"expression" : "SUM(METRICS())", "label" : "Expression label" }]`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| accountId | Specifies the AWS account ID where this metric comes from. This enables you to create a widget that contains metrics from multiple accounts on a cross-account dashboard. If you omit this, the current account is used as the default. | `string` | `null` | no |
| color | The six-digit HTML hex color code to be used for this metric. | `string` | `null` | no |
| dimensions | Map of `{ DimensionName = DimensionValue, ... }` for the metric. e.g. `{ TargetGroup = "targetgroup/hoge-tg/abcdef1234567890", LoadBalancer = "app/hoge-alb/0123456789abcdef" }` | `any` | `null` | no |
| expression | The math expression or search expression, if this is an expression instead of a single metric. In a search expression using double-quotes for an exact match, each double-quote mark must be escaped with a backslash. | `string` | `null` | no |
| id | The Id of this time series. This Id can be used as part of a math expression. The Id must start with a lowercase letter. | `string` | `null` | no |
| label | The label to display in the graph to represent this time series. | `string` | `null` | no |
| metricName | The name of the CloudWatch metric. If you have multiple entries in the metrics array, for each one after the first you may specify only `"."` to use the same metric name as the previous metric in the array. | `string` | `null` | no |
| namespace | The AWS namespace containing the metric. If you have multiple entries in the metrics array, for each one after the first you may specify only `"."` to use the same namespace as the previous metric in the array. | `string` | `null` | no |
| period | The period for this metric, in seconds. The period is the length of time represented by one data point on the graph. Valid Values: A multiple of 60, with a minimum of 60. | `number` | `null` | no |
| region | The region of the metric. If you omit this, the current Region is used as the default. | `string` | `null` | no |
| stat | The statistic for this metric, if it is to be different than the statistic used for the other metrics in the array. Valid Values: `SampleCount` \| `Average` \| `Sum` \| `Minimum` \| `Maximum` \| `p??`. | `string` | `null` | no |
| visible | Set this to `true` to have the metric appear in the graph, or `false` to have it be hidden. The default is `true`. | `bool` | `null` | no |
| yAxis | Where on the graph to display the y-axis for this metric. The default is `left`. Valid Values: `left` \| `right`. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| metric\_properties\_object | Metric array object that can be plugged into metrics array parameter widget |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
