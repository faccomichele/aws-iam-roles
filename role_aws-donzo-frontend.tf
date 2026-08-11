// Role-specific attachments can be added here when needed.resource "aws_iam_role_policy_attachment" "common" {
// Use count = contains(var.gha-roles, "repo-name") ? 1 : 0
