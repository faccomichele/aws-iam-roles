data "aws_caller_identity" "current" {}

data "aws_iam_policy" "terraform-core-ssm-read" {
  arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/aws-terraform-core-ssm-read-${local.environment}"
}

data "aws_iam_policy" "terraform-core-tf-access" {
  arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/aws-terraform-core-tf-access-${local.environment}"
}

data "aws_iam_policy" "terraform-core-s3-artifacts-access" {
  arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/aws-terraform-core-s3-artifacts-access-${local.environment}"
}

data "external" "github_repository_owner_id" {
  program = ["sh", "-c", "read query; var_name=$(echo $query | jq -r '.name'); eval val=\\$$var_name; jq -n --arg val \"$val\" '{\"value\": $val}'"]

  query = {
    name = "GITHUB_REPOSITORY_OWNER_ID"
  }
}

locals {
  github_repository_owner_id = data.external.github_repository_owner_id.result.value
}

data "external" "github_repository_id" {
  program = ["sh", "-c", "read query; var_name=$(echo $query | jq -r '.name'); eval val=\\$$var_name; jq -n --arg val \"$val\" '{\"value\": $val}'"]

  query = {
    name = "GITHUB_REPOSITORY_ID"
  }
}

locals {
  github_repository_id = data.external.github_repository_id.result.value
}
