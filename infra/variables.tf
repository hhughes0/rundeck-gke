variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default = "europe-west1"
}

variable "gcp_zone" {
  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
  default = "europe-west1-b"
}

variable "gcp_project" {
  description = "GCP Project"
  default = "#"
}

variable "initial_node_count" {
  description = "Number of worker VMs to initially create"
  default = 1
}

variable "master_username" {
  description = "Username for accessing the Kubernetes master endpoint"
  default = "#"
}

variable "master_password" {
  description = "Password for accessing the Kubernetes master endpoint"
  default = "#"
}

variable "node_machine_type" {
  description = "GCE machine type"
  default = "n1-standard-1"
}

variable "node_disk_size" {
  description = "Node disk size in GB"
  default = "20"
}
