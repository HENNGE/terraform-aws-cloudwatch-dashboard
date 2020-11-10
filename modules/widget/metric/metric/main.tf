locals {
  dimensions_array = var.dimensions == null ? null : flatten([
    for dimensionName, dimensionValue in var.dimensions : [dimensionName, dimensionValue]
  ])
  rendering_properties = {
    expression = var.expression
    color      = var.color
    label      = var.label
    period     = var.period
    stat       = var.stat
    visible    = var.visible
    yAxis      = var.yAxis
    region     = var.region
  }
  clean_rendering_properties = { for k, v in local.rendering_properties : k => v if v != null }
  metric_array = flatten([
    var.namespace,
    var.metricName,
    local.dimensions_array,
    local.clean_rendering_properties == {} ? null : local.rendering_properties
  ])
  clean_metric_array = [for item in local.metric_array : item if item != null]
}
