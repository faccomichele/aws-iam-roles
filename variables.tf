variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
}

variable "gha-roles" {
  description = "List of roles to create for GitHub Actions"
  type        = list(string)
  default     = []
}

variable "local-only" {
  description = "If true, the deployment will be done only locally, without connecting to GitHub"
  type        = bool
  default     = false
}
