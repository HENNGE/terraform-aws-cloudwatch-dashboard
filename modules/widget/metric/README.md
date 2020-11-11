# terraform-aws-cloudwatch-dashboard/modules/widget/metric

Terraform helper module to generate metric widget in a more documented way.

## Examples

### Example with simple metric

This example will create a simple metric widget in the dashboard to monitor the Healthy Host Count from 2 target groups in different region.

```hcl
module "dashboard" {
  source = "./../.."
  name = "test-dashboard"
  widgets = [module.healthy_host_count_widget.widget_object]
}

module "healthy_host_count_widget" {
  # This module
  source = "."

  title  = "Healthy Host Count in Target Group"
  region = "ap-northeast-1"
  period = 60
  metrics = [
    ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", "targetgroup/tg-name-1/0123456789abcdef", "LoadBalancer", "app/load-balancer-1/0123456789abcdef"],
    ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", "targetgroup/tg-name-2/fedcba9876543210", "LoadBalancer", "app/load-balancer-2/fedcba9876543210", { "region" : "ap-southeast-1" }],
    // Which can also be like this for the second entry in the list:
    //["...", "targetgroup/tg-name-2/fedcba9876543210", ".", "app/load-balancer-2/fedcba9876543210", { "region": "ap-southeast-1" }]
  ]
}
```


### Example with metric helper

As we can see in the example above, metrics definition is a bit cryptic, but the advantage of using that format is you can copy paste it directly from Cloudwatch console into this module.

For readability and documentation, we can also use a helper module to define those metrics in more readable way. See details in [metric/metric](./metric).

Note that you can also mix the above format with the helper.

```hcl
module "dashboard" {
  source = "./../.."
  name = "test-dashboard"
  widgets = [module.healthy_host_count_widget.widget_object]
}

module "healthy_host_count_widget" {
  # This module
  source = "."

  title  = "Healthy Host Count in Target Group"
  region = "ap-northeast-1"
  period = 60
  metrics = [
    module.healthy_host_count_metric_tokyo.metric_array_object,
    module.healthy_host_count_metric_singapore.metric_array_object,
    // If you wish to mix some other metrics with the oneliner you can do it just add the list entry below
    // ["AWS/ApplicationELB", "HealthyHostCount", "TargetGroup", "targetgroup/tg-name-44/0123456789abcdef", "LoadBalancer", "app/load-balancer-44/0123456789abcdef"]
  ]
}

module "healthy_host_count_metric_tokyo" {
  # The child module
  source = "./metric"

  namespace = "AWS/ApplicationELB"
  metricName = "HealthyHostCount"
  dimensions = {
    TargetGroup = "targetgroup/tg-name-1/0123456789abcdef"
    LoadBalancer = "app/load-balancer-1/0123456789abcdef"
  }
}

module "healthy_host_count_metric_singapore" {
  # The child module
  source = "./metric"

  namespace = "AWS/ApplicationELB"
  metricName = "HealthyHostCount"
  dimensions = {
    TargetGroup = "targetgroup/tg-name-2/fedcba9876543210"
    LoadBalancer = "app/load-balancer-2/fedcba9876543210"
  }
  region = "ap-southeast-1"
}
```

This way we can see that the metrics we're monitoring in much more verbose format.

### Example with metric helper, parameterized

We see the example above is too verbose to our liking, there are lot of copy pasting modules.

Since Terraform 0.13, we can use `count` with modules so we can parameterize the above format to something like this

```hcl
module "dashboard" {
  source = "./../.."
  name = "test-dashboard"
  widgets = [module.healthy_host_count_widget.widget_object]
}

module "healthy_host_count_widget" {
  # This module
  source = "."

  title  = "Healthy Host Count in Target Group"
  region = "ap-northeast-1"
  period = 60
  # Since module.healthy_host_count_metric[*].metric_array_object already produces a list, we don't need to do list it again
  metrics = module.healthy_host_count_metric[*].metric_array_object
}

locals {
  monitored_items = [
    {
      target_group  = "targetgroup/tg-name-1/0123456789abcdef"
      load_balancer = "app/load-balancer-1/0123456789abcdef"
      region        = "ap-northeast-1"
    },
    {
      target_group  = "targetgroup/tg-name-2/fedcba9876543210"
      load_balancer = "app/load-balancer-2/fedcba9876543210"
      region        = "ap-southeast-1"
    } 
  ]
}

module "healthy_host_count_metric" {
  # The child module
  source = "./metric"
  
  count       = length(local.monitored_items)
  namespace   = "AWS/ApplicationELB"
  metricName  = "HealthyHostCount"

  dimensions = {
    TargetGroup   = local.monitored_items[count.index]["target_group"]
    LoadBalancer  = local.monitored_items[count.index]["load_balancer"]
  }
  region = local.monitored_items[count.index]["region"]
}
```

If you have a complex metric requirements, it can be further parameterized like the example below

### Example with DynamoDB Metrics (Complex)

Suppose we want to create a dashboard that shows computed metrics, such as `DynamoDB Read Utilization` in percentage (`Consumed`/`Provisioned`).

In this example we'll create a widget that gathers DynamoDB Global Tables in 2 regions. This example will use `metrics` helper both in `metric` form and `expression` form.

```hcl
module "dashboard" {
  source = "./../.."

  name = "test-dashboard"
  widgets = [
    module.dynamo_read_metric_widget.widget_object,
  ]
}

locals {
  dynamo_tables = [
    "table1",
    "table2",
    "table3",
    "table4",
    "table5",
    "table6",
    "table7",
    "tableN"
  ]
  dynamo_regions = [
    "ap-northeast-1", "ap-southeast-1"
  ]
  # Here, we use terraform to generate the combination instead of defining them by hand, since global tables name across region is the same
  dynamodb = [
    for item in setproduct(local.dynamo_regions, local.dynamo_tables) : { region = item[0], table = item[1], id = sha512("${item[0]}.${item[1]}") }
  ]
}

module "dynamo_read_metric_widget" {
  # This module
  source = "."

  title  = "DynamoDB Read Consumed Percentage Metrics"
  region = "ap-northeast-1"
  # Remember that module produced by count is a list, we need to unpack it once, so using concat instead of list comprehension
  metrics = concat(
    module.dynamo_read_metrics_consumed[*].metric_array_object,
    module.dynamo_read_metrics_provisioned[*].metric_array_object,
    module.dynamo_read_metrics_percent[*].metric_array_object,
  )

  width  = 24
  period = 300

  yAxis = {
    left = {
      min   = 0
      max   = 100
      label = "Percent"
    }
  }

  annotations = {
    horizontal = [{
      label = "Autoscaling Utilization Target"
      value = 60
    }]
  }

}

module "dynamo_read_metrics_consumed" {
  # Child module (metric/metric)
  source = "./metric"

  count      = length(local.dynamodb)
  namespace  = "AWS/DynamoDB"
  metricName = "ConsumedReadCapacityUnits"
  dimensions = {
    TableName = local.dynamodb[count.index]["table"]
  }
  region  = local.dynamodb[count.index]["region"]
  label   = "cons:${local.dynamodb[count.index]["region"]}:${local.dynamodb[count.index]["table"]}"
  id      = "cons${local.dynamodb[count.index]["id"]}"
  stat    = "Sum"
  period  = 300
  visible = false
  yAxis   = "right"
}

module "dynamo_read_metrics_provisioned" {
  # Child module (metric/metric)
  source = "./metric"

  count      = length(local.dynamodb)
  namespace  = "AWS/DynamoDB"
  metricName = "ProvisionedReadCapacityUnits"
  dimensions = {
    TableName = local.dynamodb[count.index]["table"]
  }
  region  = local.dynamodb[count.index]["region"]
  label   = "prov:${local.dynamodb[count.index]["region"]}:${local.dynamodb[count.index]["table"]}"
  id      = "prov${local.dynamodb[count.index]["id"]}"
  stat    = "Sum"
  period  = 300
  visible = false
  yAxis   = "right"
}

module "dynamo_read_metrics_percent" {
  # Child module (metric/metric)
  source = "./metric"

  count      = length(local.dynamodb)
  expression = "100*(cons${local.dynamodb[count.index]["id"]} / prov${local.dynamodb[count.index]["id"]})/300"
  label      = "${local.dynamodb[count.index]["region"]}:${local.dynamodb[count.index]["table"]}"
  id         = "pct${local.dynamodb[count.index]["id"]}"
  yAxis      = "left"
}

```

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
| accountId | Specifies the AWS account ID where all metrics in this widget will come from. This is useful for cross-account dashboards that include widgets from multiple accounts. If you omit this, the current account is used as the default. Use this parameter only for metric widgets. You can also use an `accountId` field within each metric in the array of `metrics` to create a single widget which includes metrics from multiple accounts. | `string` | `null` | no |
| annotations | To include an alarm or annotation in the widget, specify an annotations array. Specify it in terraform map format. For more information about the format, see [Annotations Docs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Annotation-Format) | `any` | `null` | no |
| height | The height of the widget in grid units. The default is 6. Valid Values: 1–1000. | `number` | `null` | no |
| legendPosition | Specify legend to determine where the legend for the lines on the graph is displayed. Possible values for position are `right`, `bottom`, and `hidden`. | `string` | `null` | no |
| liveData | Specify `true` to display live data in the widget. Live data is data published within the last minute that has not been fully aggregated. | `bool` | `null` | no |
| metrics | List of list. Specify a metrics array to include one or more metrics (without alarms), math expressions, or search expressions. Specify in terraform map format. One `metrics` array can include 0–100 metrics and expressions. | `any` | n/a | yes |
| period | The default period, in seconds, for all metrics in this widget. The period is the length of time represented by one data point on the graph. This default can be overridden within each metric definition. Use this parameter only for metric widgets. The default is 300. Valid Values: Any multiple of 60, with 60 as the minimum. | `number` | `null` | no |
| region | The region of the metric. | `string` | n/a | yes |
| stacked | Specify `true` to display the graph as a stacked line, or `false` to display as separate lines. This parameter is ignored if `view` is `singleValue`. | `bool` | `null` | no |
| stat | The default statistic to be displayed for each metric in the array. This default can be overridden within the definition of each individual metric in the `metrics` array. Valid Values: `SampleCount` \| `Average` \| `Sum` \| `Minimum` \| `Maximum` \| `p??` | `string` | `null` | no |
| title | The title to be displayed for the graph or number. Use this parameter only for metric widgets. | `string` | `null` | no |
| view | Specify `timeSeries` to display this metric as a line graph. Specify `bar` to display it as a bar graph. Specify `pie` to display it as a pie graph. Specify `singleValue` to display it as a number. Valid Values: `timeSeries` \| `singleValue` \| `bar` \| `pie` | `string` | `null` | no |
| width | The width of the widget in grid units (in a 24-column grid). The default is 6. Valid Values: 1–24. | `number` | `null` | no |
| x | The horizontal position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: 0–23. | `number` | `null` | no |
| y | The vertical position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: Any integer, 0 or higher. | `number` | `null` | no |
| yAxis | Limits for the minimums and maximums of the y-axis, if this is a graph. This applies to every metric being graphed, unless specific metrics override it. Specify in terraform map format [YAxis format](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-YAxis-Properties-Format) | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| widget\_json | Widget JSON object (string) |
| widget\_object | Widget Terraform object (map) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
