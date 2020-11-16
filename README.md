# terraform-aws-cloudwatch-dashboard

[AWS Cloudwatch Dashboard](https://aws.amazon.com/blogs/aws/cloudwatch-dashboards-create-use-customized-metrics-views/) is a built in dashboard inside Cloudwatch to monitor metrics.
Creating them from console is easy, however if you want to manage and maintain it long term, console might not be the best way to do it.
AWS provides a way to configure the dashboard via JSON which can be maintained by IaC such as terraform, but for now, terraform only accept JSON as input for everything inside the dashboard.

As your dashboard grows, so the JSON source, making it quickly become unmaintainable.
This modules is trying to modularize JSON input for cloudwatch dashboard resource in a documented way. Parameters are taken from [here](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Alarm-Widget-Object).


## Terraform versions

Supported terraform versions are only >= 0.13.

## Example

Example to create widget is in individual `modules/widget` folder.

Creating a dashboard with this module is as easy as:

```hcl
module "dashboard" {
    source  = "HENNGE/cloudwatch-dashboard/aws"
    version = "~> 1"

    name = "My Dashboard"
    widgets = [
      // Fill in your widget objects, either raw format or from module
    ]
}
```

Embracing Terraform 0.13 `count` for `module` you can create a template widget and parameterize it like this

```hcl
module "dashboard" {
    source  = "HENNGE/cloudwatch-dashboard/aws"
    version = "~> 1"
  
    name = "My Dashboard"
    widgets = [
      module.text_widget[*].widget_object
    ]
}

module "text_widget" {
    source  = "HENNGE/cloudwatch-dashboard/aws//modules/widget/text"
    version = "~> 1"
    
    count    = 5
    markdown = "Hello World ${count.index}"
}
```

The way to use this module is to create a widget using module, then attach it to the dashboard widgets parameter.

## Versioning

This module uses Semver.

`x.y.z`

`x` shall change when there's major language or breaking feature change (e.g. 0.11 to 0.12 which drastically change the language)

`y` shall change when there's feature addition which is not breaking existing API (e.g. addition of some parameters with default value)

`z` shall change when there's documentation updates, minor fixes, etc.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| end | The end of the time range to use for each widget on the dashboard when the dashboard loads. If you specify a value for `end`, you must also specify a value for `start`. For each of these values, specify an absolute time in the ISO 8601 format. For example, `2018-12-17T06:00:00.000Z`. | `string` | `null` | no |
| name | Name of the dashboard. | `any` | n/a | yes |
| periodOverride | Use this field to specify the period for the graphs when the dashboard loads. Specifying auto causes the period of all graphs on the dashboard to automatically adapt to the time range of the dashboard. Specifying inherit ensures that the period set for each graph is always obeyed. Valid Values: auto \| inherit. | `string` | `null` | no |
| start | The start of the time range to use for each widget on the dashboard. You can specify `start` without specifying `end` to specify a relative time range that ends with the current time. In this case, the value of start must begin with `-PT` if you specify a time range in minutes or hours, and must begin with `-P` if you specify a time range in days, weeks, or months. You can then use M, H, D, W and M as abbreviations for minutes, hours, days, weeks and months. For example, `-PT5M` shows the last 5 minutes, `-PT8H` shows the last 8 hours, and `-P3M` shows the last three months. You can also use `start` along with an `end` field, to specify an absolute time range. When specifying an absolute time range, use the ISO 8601 format. For example, `2018-12-17T06:00:00.000Z`. If you omit `start`, the dashboard shows the default time range when it loads. | `string` | `null` | no |
| widgets | List of Widget object (obtained from modules/widget, terraform object) to attach to this dashboard. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| dashboard\_arn | The Amazon Resource Name (ARN) of the dashboard. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [HENNGE](https://github.com/HENNGE).

## License

Apache 2 Licensed. See LICENSE for full details.
