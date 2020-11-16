terraform {
  required_version = ">= 0.13.0"
}

locals {
  clean_properties = { for k, v in var.properties : k => v if v != null }
  widget_object = {
    type       = var.type
    x          = var.x
    y          = var.y
    width      = var.width
    height     = var.height
    properties = local.clean_properties
  }
  clean_widget_object = { for k, v in local.widget_object : k => v if v != null }
}
