output "widget_object" {
  description = "Widget Terraform object (map)"
  value       = module.log_widget.widget_object
}

output "widget_json" {
  description = "Widget JSON object (string)"
  value       = module.log_widget.widget_json
}
