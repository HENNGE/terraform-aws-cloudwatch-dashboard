variable "markdown" {
  description = "The text to be displayed by the widget."
  type        = string
}

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
