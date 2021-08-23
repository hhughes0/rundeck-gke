terraform {
  required_version = ">= 0.12"
}

provider "google" {
  credentials = ""
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}

provider "google-beta" {
  project = "${var.gcp_project}"
  region  = "${var.gcp_region}"
}

provider "helm" {
  install_tiller = false
  insecure       = true

  kubernetes {
    host                   = "${data.google_container_cluster.my_cluster.endpoint}"
    token                  = "${data.google_container_cluster.my_cluster.master_auth.0.client_key}"
    cluster_ca_certificate = "${data.google_container_cluster.my_cluster.master_auth.0.cluster_ca_certificate}"
  }
}

data "helm_repository" "incubator" {
  name = "incubator"
  url  = "https://kubernetes-charts-incubator.storage.googleapis.com"
}

resource "helm_release" "rundeck" {
  name       = "tst-rundeck"
  repository = data.helm_repository.incubator.metadata[0].name
  chart      = "rundeck"
}
/*
*/

data "google_container_cluster" "my_cluster" {
  name     = "test-k8s-cluster"
  location = "europe-west1-b"
}

resource "google_container_cluster" "test_k8s_cluster" {
  name                    = "test-k8s-cluster"
  description             = "Test K8s Cluster"
  location                = "${var.gcp_zone}"
  initial_node_count      = "${var.initial_node_count}"
  enable_kubernetes_alpha = "false"
  enable_legacy_abac      = "true"

  master_auth {
    username = "${var.master_username}"
    password = "${var.master_password}"

    client_certificate_config {
      issue_client_certificate = true
    }
  }

  node_config {
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}
