variable "project_id" {
  description = "Project ID in GCP"
}

variable "location" {
  description = "Location ID in GCP"
}

variable "region" {
  description = "Region within the location in GCP"
}

variable "app_bucket_name" {
  description = "Which bucket should the App Engine zip containing the application be deployed"
}
