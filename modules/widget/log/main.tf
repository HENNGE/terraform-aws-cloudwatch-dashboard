module "log_widget" {
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
