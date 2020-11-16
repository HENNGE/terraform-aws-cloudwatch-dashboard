variable "accountId" {
  description = "Specifies the AWS account ID where this metric comes from. This enables you to create a widget that contains metrics from multiple accounts on a cross-account dashboard. If you omit this, the current account is used as the default."
  type        = string
  default     = null
}

variable "namespace" {
  description = "The AWS namespace containing the metric. If you have multiple entries in the metrics array, for each one after the first you may specify only `\".\"` to use the same namespace as the previous metric in the array."
  type        = string
  default     = null
}

variable "metricName" {
  description = "The name of the CloudWatch metric. If you have multiple entries in the metrics array, for each one after the first you may specify only `\".\"` to use the same metric name as the previous metric in the array."
  type        = string
  default     = null
}

variable "expression" {
  description = "The math expression or search expression, if this is an expression instead of a single metric. In a search expression using double-quotes for an exact match, each double-quote mark must be escaped with a backslash."
  type        = string
  default     = null
}

variable "dimensions" {
  description = "Map of `{ DimensionName = DimensionValue, ... }` for the metric. e.g. `{ TargetGroup = \"targetgroup/hoge-tg/abcdef1234567890\", LoadBalancer = \"app/hoge-alb/0123456789abcdef\" }`"
  type        = any
  default     = null
}

variable "id" {
  description = "The Id of this time series. This Id can be used as part of a math expression. The Id must start with a lowercase letter."
  type        = string
  default     = null
}

variable "label" {
  description = "The label to display in the graph to represent this time series."
  type        = string
  default     = null
}

variable "region" {
  description = "The region of the metric. If you omit this, the current Region is used as the default."
  type        = string
  default     = null
}

// Rendering Properties Object Format

variable "color" {
  description = "The six-digit HTML hex color code to be used for this metric."
  type        = string
  default     = null
}

variable "period" {
  description = "The period for this metric, in seconds. The period is the length of time represented by one data point on the graph. Valid Values: A multiple of 60, with a minimum of 60."
  type        = number
  default     = null
}

variable "stat" {
  description = "The statistic for this metric, if it is to be different than the statistic used for the other metrics in the array. Valid Values: `SampleCount` | `Average` | `Sum` | `Minimum` | `Maximum` | `p??`."
  type        = string
  default     = null
}

variable "visible" {
  description = "Set this to `true` to have the metric appear in the graph, or `false` to have it be hidden. The default is `true`."
  type        = bool
  default     = null
}

variable "yAxis" {
  description = "Where on the graph to display the y-axis for this metric. The default is `left`. Valid Values: `left` | `right`."
  type        = string
  default     = null
}
