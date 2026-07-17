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

data "external" "all_env_vars" {
  # This runs 'env', passes it to jq, and splits the 'KEY=VALUE' lines into a valid JSON object
  program = [
    "sh", 
    "-c", 
    "env | jq -Rs 'split(\"\n\") | map(select(length > 0 and contains(\"=\"))) | map(split(\"=\")) | map({(.[0]): .[1:] | join(\"=\")}) | add'"
  ]
}
