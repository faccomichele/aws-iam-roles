variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
}

variable "gha-roles" {
  description = "List of roles to create for GitHub Actions"
  type        = list(string)
  default     = []
}

# variable "github_repository_id" {
#   description = "GitHub repository ID from Actions context (for example: ${{ github.repository_id }})"
#   type        = string
#   default     = null

#   validation {
#     condition     = var.github_repository_id == null || can(regex("^[0-9]+$", var.github_repository_id))
#     error_message = "github_repository_id must be null or a numeric string."
#   }
# }

# variable "github_actor_id" {
#   description = "GitHub actor ID from Actions context (for example: ${{ github.actor_id }})"
#   type        = string
#   default     = null

#   validation {
#     condition     = var.github_actor_id == null || can(regex("^[0-9]+$", var.github_actor_id))
#     error_message = "github_actor_id must be null or a numeric string."
#   }
# }
