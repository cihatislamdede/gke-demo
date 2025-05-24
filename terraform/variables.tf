variable "project_id" {
  description = "GCP_PROJECT_ID"
  type        = string
}

variable "region" {
  description = "GCP Region for the cluster"
  type        = string
  default     = "europe-west1"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "my-cluster"
}

variable "main_node_pool_machine_type" {
  description = "Machine type for the main node pool"
  type        = string
  default     = "n2d-standard-2" # n2d
}

variable "app_node_pool_machine_type" {
  description = "Machine type for the application node pool"
  type        = string
  default     = "n2d-standard-2" # n2d
}