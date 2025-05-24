output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
  sensitive = true
}

output "kubeconfig" {
  description = "To get the kubeconfig for the cluster, run the following command: Also check https://github.com/lensapp/lens/issues/6563#issuecomment-1402048045 for lens compatibility"
  value = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --region ${var.region} --project ${var.project_id}"
}