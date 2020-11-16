terraform {
  required_version = ">= 0.13.0"
}

locals {
  dashboard_body = {
    widgets        = flatten(var.widgets)
    end            = var.end
    start          = var.start
    periodOverride = var.periodOverride
  }
  clean_dashboard_body = { for k, v in local.dashboard_body : k => v if v != null }
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = var.name
  dashboard_body = jsonencode(local.clean_dashboard_body)
}
