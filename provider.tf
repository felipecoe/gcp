# Main provider
provider "google" {
  project = local.project-id
  region  = local.region
}

# Where the state is stored
terraform {
  backend "gcs" {
    bucket = local.terraform-state-bucket
    prefix = "terraform/state"
  }
}
