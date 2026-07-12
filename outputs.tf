output "gha_role_arns" {
	description = "ARNs of IAM roles created by this module, keyed by role name"
	value = {
		for role_name, role in aws_iam_role.gha-role : role_name => role.arn
	}
}
