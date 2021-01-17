# Main provider
provider "google" {
  project = local.project-id
  region  = local.region
}

# Where the state is stored
terraform {
  backend "gcs" {
    bucket = "native-felipecoe-test2-bucket-us-central"
    prefix = "terraform/state"
  }
}
