terraform {
  required_version = ">= 0.13.0"
}

locals {
  legend = var.legendPosition == null ? null : {
    legend = { position : var.legendPosition }
  }
}

module "widget" {
  source = "../generic"

  type   = "metric"
  x      = var.x
  y      = var.y
  width  = var.width
  height = var.height

  properties = {
    accountId   = var.accountId
    annotations = var.annotations
    liveData    = var.liveData
    legend      = local.legend
    metrics     = var.metrics
    period      = var.period
    region      = var.region
    stacked     = var.stacked
    stat        = var.stat
    title       = var.title
    view        = var.view
    yAxis       = var.yAxis
  }
}
