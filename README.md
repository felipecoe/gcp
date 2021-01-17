# GCP exercise

The terraform files in this repository create a basic python application with Flask and runs it in Google Cloud Platform App Engine.

It runs a Python Flask application that shows "Hello World" on the webpage. The zip file under the `app/` folder contains the source code of the application, which is for demonstration purposes only.

I also created a module to deploy the application because I thought initially that I could create multiple App Engine applications in different regions, but it's not possible. A new project would need to be created on another region and a new App Engine deployment should be made for high availability, using Cloud CDN to re-route traffic to the available region.

## Initial Google config

* Clone this repo
* Create a new project in your [GCP console](https://console.cloud.google.com)
* Manually create a bucket for the terraform state.
* Enable Google App Engine API [here](https://console.developers.google.com/apis/api/appengine.googleapis.com/overview)
* Create a service account to start the terraform setup [here](https://console.cloud.google.com/iam-admin/serviceaccounts/create)
* Create and download an API key for this service account
* Set the environment variable GOOGLE_CREDENTIALS with the path to the JSON file containing the service account API key

> Authenticating to GCP with a service account and a credentials file is not ideal. The users should be properly authenticated to Google using their own credentials, associated with an IAM role.

## Configure terraform

* Add the correct parameters to the `variables.tf` file:

- `project-id`: The Project ID within GCP that you just created for this exercise
- `region`: Where the bucket will be created
- `location`: Where the application will run from
- `app_bucket_name`: Where the application will be uploaded so that App Engine can be instantiated.

* Run `terraform init`

In the real world, the application would be deployed from another repository using more robust tools for CI/CD, running test suites, etc.

## Build the infra and app

* Run `terraform plan -out=/tmp/tf.plan` in the root folder of the repo
* Run `terraform apply /tmp/tf.plan` to deploy the whole infra and the application
* Run `terraform state show google_app_engine_application.app | grep default_hostname` to see the URL that the application has been deployed.

In the real world, a custom domain would be created and associated via CNAME to this App Engine URL.

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

and another (at least it didn't take almost 10 minutes as the one above):

```
google_app_engine_application.app: Creation complete after 14s [id=<redacted>]

Error: Error creating StandardAppVersion: googleapi: Error 404: Unable to retrieve P4SA: [service-562739294791@gcp-gae-service.iam.gserviceaccount.com] from GAIA. Could be GAIA propagation delay or request from deleted apps.
```
