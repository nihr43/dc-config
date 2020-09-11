resource "kubernetes_cron_job" "ups-metrics_runner" {
  metadata {
    name = "ups-metrics-runner"
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 5
    schedule                      = "* * * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit = 2
        template {
          metadata {}
          spec {
            container {
              name    = "ups-metrics-runner"
              image   = "docker-registry.localnet:5000/ups-metrics_runner:latest"
              command = ["/bin/sh", "init.sh"]
            }
            restart_policy = "OnFailure"
          }
        }
      }
    }
  }
}
