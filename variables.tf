variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 2
  description = "GKE nodes number"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default     = "main"
  description = "GKE cluster name"
}

variable "GKE_POOL_NAME" {
  type        = string
  default     = "main"
  description = "GKE pool name"
}

variable "GITHUB_TOKEN" {
  sensitive = true
  type      = string
}

variable "github_token" {
  sensitive = true
  type      = string
}

variable "GITHUB_OWNER" {
  type = string
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
}

variable "FLUX_GITHUB_REPO_TARGET_PATH" {
  type        = string
  default     = "clusterscd "
  description = "Flux manifests subdirectory"
}

variable "keyring_name" {
  type    = string
  default = "sops-flux11"  # Replace with the actual name of your existing KeyRing
}
