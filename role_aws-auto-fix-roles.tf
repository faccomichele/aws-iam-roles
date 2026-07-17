resource "aws_iam_role_policy" "aws-auto-fix-roles" {
  count = contains(var.gha-roles, "aws-auto-fix-roles") ? 1 : 0

  name = "aws-auto-fix-roles-inline"
  role = aws_iam_role.gha-role["aws-auto-fix-roles"].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "IAMRoleManagement"
        Effect = "Allow"
        Action = [
          "iam:CreateRole",
          "iam:GetRole",
          "iam:DeleteRole",
          "iam:TagRole",
          "iam:UntagRole",
          "iam:ListRoleTags",
          "iam:PutRolePolicy",
          "iam:GetRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:PassRole"
        ]
        Resource = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-auto-fix-roles-*",
        ]
      },
      {
        Sid    = "LambdaManagement"
        Effect = "Allow"
        Action = [
          "lambda:CreateFunction",
          "lambda:GetFunction",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:DeleteFunction",
          "lambda:TagResource",
          "lambda:UntagResource",
          "lambda:ListTags",
          "lambda:GetFunctionCodeSigningConfig",
          "lambda:GetPolicy",
          "lambda:ListVersionsByFunction",
        ]
        Resource = [
          "arn:aws:lambda:*:${data.aws_caller_identity.current.account_id}:function:aws-auto-fix-roles-*",
        ]
      },
      {
        Sid    = "CloudWatchLogsManagement"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:DescribeLogGroups",
          "logs:DeleteLogGroup",
          "logs:PutRetentionPolicy",
          "logs:DeleteRetentionPolicy",
          "logs:TagLogGroup",
          "logs:UntagLogGroup",
          "logs:ListTagsLogGroup",
          "logs:TagResource",
          "logs:UntagResource",
          "logs:ListTagsForResource",
        ]
        Resource = [
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/aws-auto-fix-roles-*",
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/states/aws-auto-fix-roles/*",
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group::log-stream:*",
        ]
      },
      {
        Sid    = "EventBridgeManagement"
        Effect = "Allow"
        Action = [
          "events:PutRule",
          "events:DescribeRule",
          "events:DeleteRule",
          "events:TagResource",
          "events:UntagResource",
          "events:ListTagsForResource",
          "events:PutTargets",
          "events:RemoveTargets",
          "events:ListTargetsByRule",
        ]
        Resource = [
          "arn:aws:events:*:${data.aws_caller_identity.current.account_id}:rule/aws-auto-fix-roles-*",
        ]
      },
      {
        Sid    = "StepFunctionsManagement"
        Effect = "Allow"
        Action = [
          "states:CreateStateMachine",
          "states:DescribeStateMachine",
          "states:UpdateStateMachine",
          "states:DeleteStateMachine",
          "states:TagResource",
          "states:UntagResource",
          "states:ListTagsForResource",
          "states:ListStateMachineVersions",
        ]
        Resource = [
          "arn:aws:states:*:${data.aws_caller_identity.current.account_id}:stateMachine:aws-auto-fix-roles-*",
        ]
      },
      {
        Sid    = "StepFunctionsValidateAny"
        Effect = "Allow"
        Action = [
          "states:ValidateStateMachineDefinition",
        ]
        Resource = [
          "arn:aws:states:*:${data.aws_caller_identity.current.account_id}:stateMachine:*",
        ]
      },
      {
        Sid    = "CloudTrailManagement"
        Effect = "Allow"
        Action = [
          "cloudtrail:CreateTrail",
          "cloudtrail:UpdateTrail",
          "cloudtrail:DeleteTrail",
          "cloudtrail:GetTrail",
          "cloudtrail:GetTrailStatus",
          "cloudtrail:StartLogging",
          "cloudtrail:StopLogging",
          "cloudtrail:AddTags",
          "cloudtrail:RemoveTags",
          "cloudtrail:ListTags",
          "cloudtrail:PutEventSelectors",
          "cloudtrail:GetEventSelectors",
        ]
        Resource = [
          "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/aws-auto-fix-roles-*",
        ]
      },
      {
        Sid    = "CloudTrailDescribeTrails"
        Effect = "Allow"
        Action = [
          "cloudtrail:DescribeTrails",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "S3CloudTrailBucketManagement"
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:GetBucketAcl",
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "s3:DeleteBucketPolicy",
          "s3:GetLifecycleConfiguration",
          "s3:PutLifecycleConfiguration",
          "s3:DeleteLifecycleConfiguration",
          "s3:GetBucketPublicAccessBlock",
          "s3:PutBucketPublicAccessBlock",
          "s3:GetBucketTagging",
          "s3:PutBucketTagging",
          "s3:GetBucketVersioning",
          "s3:GetBucketLogging",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketCORS",
          "s3:GetBucketWebsite",
          "s3:GetBucketNotification",
          "s3:GetEncryptionConfiguration",
          "s3:GetAccelerateConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:ListBucket",
        ]
        Resource = [
          "arn:aws:s3:::aws-auto-fix-roles-cloudtrail-*",
        ]
      },
      {
        Sid    = "SSMDescribeParameters"
        Effect = "Allow"
        Action = [
          "ssm:DescribeParameters",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "SSMParameterManagement"
        Effect = "Allow"
        Action = [
          "ssm:PutParameter",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:DeleteParameter",
          "ssm:AddTagsToResource",
          "ssm:RemoveTagsFromResource",
          "ssm:ListTagsForResource",
        ]
        Resource = [
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/${local.organization}/aws-auto-fix-roles/*",
        ]
      },
    ]
  })
}