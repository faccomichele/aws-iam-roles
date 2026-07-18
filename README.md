# aws-iam-roles
Central IAM Roles repository to handle them as IaC
<!-- 
## GitHub Actions Context In Terraform

Terraform does not read arbitrary shell environment variables directly.
When running in GitHub Actions, pass the GitHub context values using `TF_VAR_` environment variables:

```yaml
- name: Terraform Apply
	env:
		TF_VAR_github_repository_id: ${{ github.repository_id }}
		TF_VAR_github_actor_id: ${{ github.actor_id }}
	run: |
		terraform init
		terraform apply -auto-approve
```

These values are available in Terraform as:

- `var.github_repository_id`
- `var.github_actor_id`
- `local.github_repository_id`
- `local.github_actor_id` -->
