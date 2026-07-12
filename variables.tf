variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
}

variable "gha-roles" {
  description = "List of roles to create for GitHub Actions"
  type        = list(string)
  default     = []
}
