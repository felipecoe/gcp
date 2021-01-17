resource "google_app_engine_standard_app_version" "hello" {
  version_id = "v1-${var.location}"
  project    = var.project_id
  service    = "default"
  runtime    = "python39"

  entrypoint {
    shell = "gunicorn -b :$PORT main:app"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.bucket.name}/${google_storage_bucket_object.object.name}"
    }
  }

  env_variables = {
    port = "8080"
  }

  automatic_scaling {
    max_concurrent_requests = 10
    min_idle_instances = 1
    max_idle_instances = 3
    min_pending_latency = "1s"
    max_pending_latency = "5s"
    standard_scheduler_settings {
      target_cpu_utilization = 0.5
      target_throughput_utilization = 0.75
      min_instances = 2
      max_instances = 10
    }
  }

  delete_service_on_destroy = true
  noop_on_destroy = true
}

resource "google_storage_bucket" "bucket" {
  project = var.project_id
  name = var.app_bucket_name
  location = var.region
}

resource "google_storage_bucket_object" "object" {
  name   = "hello.zip"
  bucket = google_storage_bucket.bucket.name
  source = "app/hello.zip"
}
