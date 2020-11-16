terraform {
  required_version = ">= 0.13.0"
}

module "widget" {
  source = "../generic"

  type   = "text"
  x      = var.x
  y      = var.y
  width  = var.width
  height = var.height

  properties = {
    markdown = var.markdown
  }
}
