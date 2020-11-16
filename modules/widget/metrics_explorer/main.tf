terraform {
  required_version = ">= 0.13.0"
}

locals {
  labels_expanded = var.labelsMap == null ? [] : flatten([
    for k, v in var.labelsMap : [
      for val in try([tostring(v)], tolist(v)) :
      {
        key   = k,
        value = val
      }
    ]
  ])
  labels          = var.labels == null ? [] : var.labels
  labels_combined = local.labels == [] && local.labels_expanded == [] ? null : concat(local.labels, local.labels_expanded)
}

module "widget" {
  source = "../generic"

  type   = "explorer"
  x      = var.x
  y      = var.y
  width  = var.width
  height = var.height

  properties = {
    metrics       = var.metrics
    aggregateBy   = var.aggregateBy
    labels        = local.labels_combined
    widgetOptions = var.widgetOptions
    period        = var.period
    splitBy       = var.splitBy
    title         = var.title
  }
}
