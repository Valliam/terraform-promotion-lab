variable "environment" {
  type = string
}

variable "release_version" {
  type = string
}

variable "forecast_interval_minutes" {
  type = number
}

variable "worker_count" {
  type = number
}

# Safe lab resource: this creates no cloud resources.
# Think of it as standing in for Azure + Databricks resources.
resource "terraform_data" "energy_forecast_job" {
  input = {
    environment               = var.environment
    job_name                  = "energy-demand-forecast"
    release_version           = var.release_version
    forecast_interval_minutes = var.forecast_interval_minutes
    worker_count              = var.worker_count
  }
}

output "job_configuration" {
  value = terraform_data.energy_forecast_job.output
}
