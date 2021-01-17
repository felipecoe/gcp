resource "google_app_engine_application" "app" {
  project     = local.project-id
  location_id = local.location
}

module "app_uscentral" {
  source = "./modules/app/"
  project_id = local.project-id
  location = local.location
  region = local.region
}

#module "app_useast" {
#source = "./modules/app/"
#project_id = local.project-id
#location = "us-east1"
#region = "us-east1"
#}
