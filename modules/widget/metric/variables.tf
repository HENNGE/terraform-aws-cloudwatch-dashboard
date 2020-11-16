variable "accountId" {
  description = "Specifies the AWS account ID where all metrics in this widget will come from. This is useful for cross-account dashboards that include widgets from multiple accounts. If you omit this, the current account is used as the default. Use this parameter only for metric widgets. You can also use an `accountId` field within each metric in the array of `metrics` to create a single widget which includes metrics from multiple accounts."
  type        = string
  default     = null
}

variable "annotations" {
  description = "To include an alarm or annotation in the widget, specify an annotations array. Specify it in terraform map format. For more information about the format, see [Annotations Docs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Annotation-Format)"
  type        = any
  default     = null
}

variable "liveData" {
  description = "Specify `true` to display live data in the widget. Live data is data published within the last minute that has not been fully aggregated."
  type        = bool
  default     = null
}

variable "legendPosition" {
  description = "Specify legend to determine where the legend for the lines on the graph is displayed. Possible values for position are `right`, `bottom`, and `hidden`."
  type        = string
  default     = null
}

variable "metrics" {
  description = "List of list. Specify a metrics array to include one or more metrics (without alarms), math expressions, or search expressions. Specify in terraform map format. One `metrics` array can include 0–100 metrics and expressions."
  type        = any
}

variable "period" {
  description = "The default period, in seconds, for all metrics in this widget. The period is the length of time represented by one data point on the graph. This default can be overridden within each metric definition. Use this parameter only for metric widgets. The default is 300. Valid Values: Any multiple of 60, with 60 as the minimum."
  type        = number
  default     = null
}

variable "region" {
  description = "The region of the metric."
  type        = string
}

variable "stacked" {
  description = "Specify `true` to display the graph as a stacked line, or `false` to display as separate lines. This parameter is ignored if `view` is `singleValue`."
  type        = bool
  default     = null
}

variable "stat" {
  description = "The default statistic to be displayed for each metric in the array. This default can be overridden within the definition of each individual metric in the `metrics` array. Valid Values: `SampleCount` | `Average` | `Sum` | `Minimum` | `Maximum` | `p??`"
  type        = string
  default     = null
}

variable "title" {
  description = "The title to be displayed for the graph or number. Use this parameter only for metric widgets."
  type        = string
  default     = null
}

variable "view" {
  description = "Specify `timeSeries` to display this metric as a line graph. Specify `bar` to display it as a bar graph. Specify `pie` to display it as a pie graph. Specify `singleValue` to display it as a number. Valid Values: `timeSeries` | `singleValue` | `bar` | `pie`"
  type        = string
  default     = null
}

variable "yAxis" {
  description = "Limits for the minimums and maximums of the y-axis, if this is a graph. This applies to every metric being graphed, unless specific metrics override it. Specify in terraform map format [YAxis format](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-YAxis-Properties-Format)"
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
