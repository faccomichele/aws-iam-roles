locals {
  environment  = terraform.workspace
  organization = var.tags["Organization"] != null ? var.tags["Organization"] : "unknown"
  tags         = var.tags

  common_role_policy_arns = toset([
    data.aws_iam_policy.terraform-core-ssm-read.arn,
    data.aws_iam_policy.terraform-core-tf-access.arn,
    data.aws_iam_policy.terraform-core-s3-artifacts-access.arn,
  ])

  common_role_policy_attachments = {
    for pair in setproduct(toset(var.gha-roles), local.common_role_policy_arns) : "${pair[0]}|${pair[1]}" => {
      role_name  = pair[0]
      policy_arn = pair[1]
    }
  }
  
  gha_common_assume_policy = {
    for role_name in var.gha-roles : role_name => jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Principal = {
            Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
          }
          Action = "sts:AssumeRoleWithWebIdentity"
          Condition = {
            StringEquals = {
              "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
              "token.actions.githubusercontent.com:sub" = "repo:${local.organization}/${role_name}:*"
            }
          }
        }
      ]
    })
  }
}
