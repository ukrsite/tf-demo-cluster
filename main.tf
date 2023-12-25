module "gke_cluster" {
  source         = "github.com/den-vasyliev/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = 1
}

provider "github" {
  owner = var.github_org
  token = var.github_token
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = var.github_repository
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

provider "flux" {
  kubernetes = {
    host                   = gke_cluster.this.endpoint
    client_certificate     = gke_cluster.this.client_certificate
    client_key             = gke_cluster.this.client_key
    cluster_ca_certificate = gke_cluster.this.cluster_ca_certificate
  }
  git = {
    url = "ssh://git@github.com/${var.github_org}/${var.github_repository}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]

  path = "clusters/demo"
}
