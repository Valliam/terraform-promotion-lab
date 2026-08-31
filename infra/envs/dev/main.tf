terraform {
  required_version = ">= 1.5.0"
}

variable "release_version" {
  type = string
}

variable "forecast_interval_minutes" {
  type = number
}

module "data_platform" {
  source = "../../modules/data-platform"

  environment               = "dev"
  release_version           = var.release_version
  forecast_interval_minutes = var.forecast_interval_minutes
  worker_count              = 1
}

output "job_configuration" {
  value = module.data_platform.job_configuration
}
