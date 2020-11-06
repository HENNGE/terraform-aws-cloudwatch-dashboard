locals {
  widget_object = {
    type       = var.type
    x          = var.x
    y          = var.y
    width      = var.width
    height     = var.height
    properties = var.properties
  }
  clean_widget_object = { for k, v in local.widget_object : k => v if v != null }
}
