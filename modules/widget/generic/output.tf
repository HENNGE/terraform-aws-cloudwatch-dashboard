output "widget_object" {
  description = "Widget Terraform object (map)"
  value       = local.clean_widget_object
}

output "widget_json" {
  description = "Widget JSON object (string)"
  value       = jsonencode(local.clean_widget_object)
}
