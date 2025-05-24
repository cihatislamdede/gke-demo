provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  # 1. Logging and Monitoring disabled
  logging_service    = "none"
  monitoring_service = "none"

  # We remove the default node pool because we will define our own node pools
  remove_default_node_pool = true
  initial_node_count       = 1 # for the default node pool but becomes unnecessary when remove_default_node_pool is true

  # min_master_version = "1.30"
}

# 2. Node Pools
resource "google_container_node_pool" "main_pool" {
  name       = "main-pool"
  project    = var.project_id
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1 # Fixed number of nodes

  node_config {
    machine_type = var.main_node_pool_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    # We can add a special tag to main-pool, in case we need it in the future.
    labels = {
      "pool-type" = "main"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true # Recommended
  }
}

resource "google_container_node_pool" "application_pool" {
  name    = "application-pool"
  project = var.project_id
  location   = var.region
  cluster = google_container_cluster.primary.name

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type = var.app_node_pool_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    # application-pool-specific tag, to be used to redirect pods here
    labels = {
      "pool-name" = "application-pool"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true # Recommended
  }
}