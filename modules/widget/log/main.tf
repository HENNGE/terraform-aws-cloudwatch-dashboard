terraform {
  required_version = ">= 0.13.0"
}

module "widget" {
  source = "../generic"

  type   = "log"
  x      = var.x
  y      = var.y
  width  = var.width
  height = var.height

  properties = {
    region = var.region
    title  = var.title
    query  = var.query
    view   = var.view
  }
}
