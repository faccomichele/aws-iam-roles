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

data "external" "gh_vars" {
  program = ["cat", "gh_vars.json"]
}

data "aws_kms_alias" "dynamodb_us-east-1" {
  provider  = aws.us-east-1
  name      = "alias/aws/dynamodb"
}
