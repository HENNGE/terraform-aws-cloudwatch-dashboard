variable "aggregateBy" {
  description = "An object that specifies how to aggregate metrics from multiple resources. The valid values for the key field in this object are the keys of tags and resource properties. This object contains the following fields. `key`: The tag or resource property key to use for aggregating the metrics. `func`: The aggregation function to use. Valid values are `AVG` | `MIN` | `MAX` | `STDDEV` | `SUM`."
  type        = map(any)
  default     = null
}

variable "labels" {
  description = "An array of the tags or the resource properties that are used to determine which metrics are displayed in the widget. Expected input `[ { key = \"key\" , value = \"value\"}, { key = \"anotherkey\", value = \"val\" }, ... ]`. If you specify different keys, then only the resources that match all of the key/value pairs are displayed. If you specify multiple values for a single key, then resources that match any of the values for that key are displayed. [Docs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Metric-Explorer-Object)."
  type        = any
  default     = null
}

variable "labelsMap" {
  description = "Same as parameter `labels` but can be supplied as map directly. If you want to specify multiple values for a single key, do so with list. Example: `{ Project = \"this_project\", OtherTag = [\"multiple\", \"values\"] }."
  type        = any
  default     = null
}

variable "metrics" {
  description = "List of map. Specify a metrics array to include one or more metrics. One metrics array can include 1–100 metrics. Each object in the array must contain the following fields. `metricName`, `resourceType`, `stat`. Example: `[ { metricName = \"CPUUtilization\" , resourceType = \"AWS::EC2::Instance\" , stat = \"Average\"} , {...other metrics}]`"
  type        = any
  default     = null
}

variable "period" {
  description = "The default period, in seconds, for all metrics in this widget. The period is the length of time represented by one data point on the graph. The default is 300. Valid Values: Any multiple of 60, with 60 as the minimum."
  type        = number
  default     = null
}

variable "splitBy" {
  description = "Specifies how to split the metrics from multiple resources into different lines on a graph, or into different graphs. The valid values are the keys of tags, and the keys of resource properties."
  type        = string
  default     = null
}

variable "title" {
  description = "The title to be displayed for the widget. The default is `Explorer`."
  type        = string
  default     = null
}

variable "widgetOptions" {
  description = "An object that specifies how the widget appears on the dashboard. It can contain the following fields. `legend`, `rowsPerPage`, `stacked`, `view`, `widgetsPerRow`. Example: `{ legend = { position = \"bottom\" }, view = \"timeSeries\", rowsPerPage = 8, widgetsPerRow = 2 }`"
  type        = any
  default     = null
}

// Layout
variable "x" {
  description = "The horizontal position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: 0–23."
  type        = number
  default     = null
}

variable "y" {
  description = "The vertical position of the widget on the 24-column dashboard grid. The default is the next available position. Valid Values: Any integer, 0 or higher."
  type        = number
  default     = null
}

variable "width" {
  description = "The width of the widget in grid units (in a 24-column grid). The default is 6. Valid Values: 1–24."
  type        = number
  default     = null
}

variable "height" {
  description = "The height of the widget in grid units. The default is 6. Valid Values: 1–1000."
  type        = number
  default     = null
}
