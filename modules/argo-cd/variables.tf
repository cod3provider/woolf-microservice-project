variable "name" {
  description = "Helm-release name"
  type        = string
  default     = "argo-cd"
}

variable "namespace" {
  description = "K8s namespace for Argo CD"
  type        = string
  default     = "argocd"
}

variable "chart_version" {
  description = "Chart Argo CD version"
  type        = string
  default     = "5.46.4"
}