terraform {
  required_version = ">= 0.13.0"
}

locals {
  dimensions_array = var.dimensions == null ? null : flatten([
    for dimensionName, dimensionValue in var.dimensions : [dimensionName, dimensionValue]
  ])
  rendering_properties = {
    accountId  = var.accountId
    expression = var.expression
    id         = var.id
    label      = var.label
    region     = var.region
    color      = var.color
    period     = var.period
    stat       = var.stat
    visible    = var.visible
    yAxis      = var.yAxis
  }
  clean_rendering_properties = { for k, v in local.rendering_properties : k => v if v != null }
  metric_array = flatten([
    var.namespace,
    var.metricName,
    local.dimensions_array,
    local.clean_rendering_properties == {} ? null : local.clean_rendering_properties
  ])
  clean_metric_array = [for item in local.metric_array : item if item != null]
}
