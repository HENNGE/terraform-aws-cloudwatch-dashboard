# terraform-aws-cloudwatch-dashboard/modules/widget/metrics_explorer

A widget of type explorer represents a metrics explorer widget. For more information, see [Use Metrics Explorer to Monitor Resources by Their Tags and Properties](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Metrics-Explorer.html)

## Example

```hcl
module "metrics_explorer" {
  // This module
  source = "."
  
  metrics = [
    {
      metricName   = "CPUUtilization"
      resourceType = "AWS::EC2::Instance"
      stat         = "Average"
    },
    {
      metricName   = "NetworkIn"
      resourceType = "AWS::EC2::Instance"
      stat         = "Average"
    },
    {
      metricName   = "NetworkOut"
      resourceType = "AWS::EC2::Instance"
      stat         = "Average"
    },
  ]

  // If you're too lazy to convert metrics obtained from console to terraform format, you can also do like this
  //  metrics = [
  //    {
  //      "metricName" : "CPUUtilization",
  //      "resourceType" : "AWS::EC2::Instance",
  //      "stat" : "Average"
  //    },
  //    {
  //      "metricName" : "NetworkIn",
  //      "resourceType" : "AWS::EC2::Instance",
  //      "stat" : "Average"
  //    },
  //    {
  //      "metricName" : "NetworkOut",
  //      "resourceType" : "AWS::EC2::Instance",
  //      "stat" : "Average"
  //    }
  //  ]

  aggregateBy = {
    key  = "InstanceType"
    func = "MAX"
  }

  labelsMap = {
    State = "running"
  }
  // Equivalent with labelsMap, can also be specified like this or in both form
  //  labels = [
  //    {
  //      key = State
  //      value = "running"
  //    }
  //  ]

  widgetOptions = {
    legend = {
      position = "bottom"
    }
    view          = "timeSeries"
    rowsPerPage   = 8
    widgetsPerRow = 2
  }
  period  = 300
  splitBy = "AvailabilityZone"
  title   = "Running EC2 Instances by AZ"
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
| aggregateBy | An object that specifies how to aggregate metrics from multiple resources. The valid values for the key field in this object are the keys of tags and resource properties. This object contains the following fields. `key`: The tag or resource property key to use for aggregating the metrics. `func`: The aggregation function to use. Valid values are `AVG` \| `MIN` \| `MAX` \| `STDDEV` \| `SUM`. | `map(any)` | `null` | no |
| height | The height of the widget in grid units. The default is 6. Valid Values: 1–1000. | `number` | `null` | no |
| labels | An array of the tags or the resource properties that are used to determine which metrics are displayed in the widget. Expected input `[ { key = "key" , value = "value"}, { key = "anotherkey", value = "val" }, ... ]`. If you specify different keys, then only the resources that match all of the key/value pairs are displayed. If you specify multiple values for a single key, then resources that match any of the values for that key are displayed. [Docs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Metric-Explorer-Object). | `any` | `null` | no |
| labelsMap | Same as parameter `labels` but can be supplied as map directly. If you want to specify multiple values for a single key, do so with list. Example: `{ Project = "this_project", OtherTag = ["multiple", "values"] }.` | `any` | `null` | no |
| metrics | List of map. Specify a metrics array to include one or more metrics. One metrics array can include 1–100 metrics. Each object in the array must contain the following fields. `metricName`, `resourceType`, `stat`. Example: `[ { metricName = "CPUUtilization" , resourceType = "AWS::EC2::Instance" , stat = "Average"} , {...other metrics}]` | `any` | `null` | no |
| period | The default period, in seconds, for all metrics in this widget. The period is the length of time represented by one data point on the graph. The default is 300. Valid Values: Any multiple of 60, with 60 as the minimum. | `number` | `null` | no |
| splitBy | Specifies how to split the metrics from multiple resources into different lines on a graph, or into different graphs. The valid values are the keys of tags, and the keys of resource properties. | `string` | `null` | no |
| title | The title to be displayed for the widget. The default is `Explorer`. | `string` | `null` | no |
| widgetOptions | An object that specifies how the widget appears on the dashboard. It can contain the following fields. `legend`, `rowsPerPage`, `stacked`, `view`, `widgetsPerRow`. Example: `{ legend = { position = "bottom" }, view = "timeSeries", rowsPerPage = 8, widgetsPerRow = 2 }` | `any` | `null` | no |
| width | The width of the widget in grid units (in a 24-column grid). The default is 6. Valid Values: 1–24. | `number` | `null` | no |
| x | The horizontal position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: 0–23. | `number` | `null` | no |
| y | The vertical position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: Any integer, 0 or higher. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| widget\_json | Widget JSON object (string) |
| widget\_object | Widget Terraform object (map) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
