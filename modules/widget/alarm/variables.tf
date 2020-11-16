variable "alarms" {
  description = "An array of alarm ARNs to include in the widget. The array can have 1-100 ARNs."
  type        = list(string)
}

variable "sortBy" {
  description = "Specifies how to sort the alarms in the widget. Valid Values: `default` | `stateUpdatedTimestamp` | `timestamp`."
  type        = string
  default     = null
}

variable "states" {
  description = "Use this field to filter the list of alarms displayed in the widget to only those alarms currently in the specified states. You can specify one or more alarm states in the value for this field. The alarm states that you can specify are `ALARM`, `INSUFFICIENT_DATA`, and `OK`. If you omit this field or specify an empty array, all the alarms specifed in `alarms` are displayed."
  type        = list(string)
  default     = null
}

variable "title" {
  description = "The title text to be displayed by the widget."
  type        = string
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
