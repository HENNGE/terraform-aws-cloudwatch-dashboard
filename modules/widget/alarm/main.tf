terraform {
  required_version = ">= 0.13.0"
}

module "widget" {
  source = "../generic"

  type   = "alarm"
  x      = var.x
  y      = var.y
  width  = var.width
  height = var.height

  properties = {
    alarms = var.alarms
    sortBy = var.sortBy
    states = var.states
    title  = var.title
  }
}
