# GCP exercise

The terraform files in this repository create a basic python application with Flask and runs it in Google Cloud Platform App Engine.

## Initial config

* Clone this repo
* Make sure you have you have the [gcloud cli](https://cloud.google.com/sdk/gcloud/) ready to go, where you are authenticated with `gcloud auth application-default login` 
* Create a new project in your [GCP console](https://console.cloud.google.com)
* Manually create a bucket for the terraform state and add it to `variables.tf`, parameter `terraform-state-bucket`
* Enable Google Cloud Build API [here](https://console.developers.google.com/apis/api/cloudbuild.googleapis.com/overview)
* Run `terraform init`

## Build the infra and app

* Run `terraform plan -out=/tmp/tf.plan` in the root folder of the repo, followed by a `terraform apply /tmp/tf.plan`

## Destroy the infra

* Run `terraform destroy` and proceed to shutdown your [GCP project settings](https://console.cloud.google.com/iam-admin/settings)


## Common GCP Fails

1) The Frankfurt region (europe-west3) doesn't have a lot of capacity. 

```
ERROR: (gcloud.app.deploy) Error Response: [8] The region europe-west3 does not have enough resources available to fulfill the request. Please try again later.
```

2) App Engine Flexible is not very reliable

```
google_app_engine_flexible_app_version.hello: Still creating... [9m50s elapsed]
Error: Error creating FlexibleAppVersion: googleapi: Error 500: Internal error encountered.
```


