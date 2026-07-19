resource "aws_iam_role_policy" "aws-simple-saml-idp" {
  count = contains(var.gha-roles, "aws-simple-saml-idp") ? 1 : 0

  name = "aws-simple-saml-idp-inline"
  role = aws_iam_role.gha-role["aws-simple-saml-idp"].name

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
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PassRole"
        ]
        Resource = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/simple-saml-idp-lambda-${local.environment}",
        ]
      },
      {
        Sid    = "LambdaManagement"
        Effect = "Allow"
        Action = [
          "lambda:CreateFunction",
          "lambda:DeleteFunction",
          "lambda:GetFunction",
          "lambda:GetFunctionConfiguration",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:ListVersionsByFunction",
          "lambda:PublishLayerVersion",
          "lambda:DeleteLayerVersion",
          "lambda:GetLayerVersion",
          "lambda:TagResource",
          "lambda:UntagResource",
          "lambda:ListTags",
          "lambda:AddPermission",
          "lambda:RemovePermission",
          "lambda:GetPolicy"
        ],
        Resource = [
          "arn:aws:lambda:*:${data.aws_caller_identity.current.account_id}:function:simple-saml-idp-*-${local.environment}",
          "arn:aws:lambda:*:${data.aws_caller_identity.current.account_id}:layer:simple-saml-idp-*-${local.environment}",
          "arn:aws:lambda:*:${data.aws_caller_identity.current.account_id}:layer:simple-saml-idp-*-${local.environment}:*",
              
        ]
      },
      {
        Sid    = "APIGatewayManagement"
        Effect = "Allow"
        Action = [
          "apigateway:GET",
          "apigateway:POST",
          "apigateway:PUT",
          "apigateway:PATCH",
          "apigateway:DELETE",
          "apigateway:TagResource",
          "apigateway:UntagResource",
        ],
        Resource = [
          "arn:aws:apigateway:*::/apis",
          "arn:aws:apigateway:*::/apis/*",
          "arn:aws:apigateway:*::/tags/*",
        ]
      },
      {
        Sid    = "DynamoDBManagement"
        Effect = "Allow"
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeTable",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:ListTagsOfResource",
          "dynamodb:TagResource",
          "dynamodb:UntagResource",
          "dynamodb:UpdateTable",
          "dynamodb:UpdateContinuousBackups",
          "dynamodb:UpdateTimeToLive",
        ],
        Resource = [
          "arn:aws:dynamodb:*:${data.aws_caller_identity.current.account_id}:table/simple-saml-idp-*-${local.environment}",
        ]
      },
      {
        Sid    = "KMSRoleManagement"
        Effect = "Allow"
        Action = [
          "kms:DescribeKey"
        ],
        Resource = [
          data.aws_kms_alias.dynamodb_us-east-1.target_key_arn,
        ]
      },
      {
        Sid    = "SSMParameterManagement"
        Effect = "Allow"
        Action = [
          "ssm:PutParameter",
          "ssm:DeleteParameter",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:DescribeParameters",
          "ssm:AddTagsToResource",
          "ssm:RemoveTagsFromResource",
          "ssm:ListTagsForResource",
        ],
        Resource = [
          "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/simple-saml-idp/${local.environment}/*",

        ]
      },
      {
        Sid    = "S3BucketManagement"
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy",
          "s3:GetBucketVersioning",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetEncryptionConfiguration",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketLogging",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketTagging",
          "s3:GetBucketWebsite",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketObjectLockConfiguration",
          "s3:PutBucketPolicy",
          "s3:PutBucketVersioning",
          "s3:PutBucketPublicAccessBlock",
          "s3:PutEncryptionConfiguration",
          "s3:PutBucketAcl",
          "s3:PutBucketTagging",
          "s3:DeleteBucketPolicy",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucketVersions",
          "s3:ListBucketMultipartUploads",
          "s3:AbortMultipartUpload",
          "s3:PutObjectAcl",
          "s3:PutObjectTagging",
          "s3:GetObjectTagging",
          "s3:GetObjectAcl",
          "s3:PutLifecycleConfiguration"
        ],
        Resource = [
          "arn:aws:s3:::simple-saml-idp-login-${local.environment}-*",
          "arn:aws:s3:::simple-saml-idp-login-${local.environment}-*/*"
        ]
      },
      {
        Sid    = "CloudFrontManagement"
        Effect = "Allow"
        Action = [
          "cloudfront:CreateDistribution",
          "cloudfront:GetDistribution",
          "cloudfront:GetDistributionConfig",
          "cloudfront:UpdateDistribution",
          "cloudfront:DeleteDistribution",
          "cloudfront:TagResource",
          "cloudfront:ListTagsForResource",
          "cloudfront:CreateCloudFrontOriginAccessIdentity",
          "cloudfront:GetCloudFrontOriginAccessIdentity",
          "cloudfront:DeleteCloudFrontOriginAccessIdentity",
          "cloudfront:GetInvalidation",
          "cloudfront:CreateInvalidation"
        ],
        Resource = [
          "*"
        ]
      },
      {
        Sid    = "IAMPolicyReadAccess"
        Effect = "Allow"
        Action = [
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:ListPolicyVersions"
        ],
        Resource = [
          "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
        ]
      },
      {
        Sid    = "CloudWatchLogsManagement"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:DeleteLogGroup",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:ListTagsLogGroup",
          "logs:TagLogGroup",
          "logs:UntagLogGroup",
          "logs:PutRetentionPolicy",
          "logs:DeleteRetentionPolicy"
        ],
        Resource = [
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/simple-saml-idp-*-${local.environment}",
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/simple-saml-idp-*-${local.environment}:*",
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/apigateway/simple-saml-idp-${local.environment}",
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/apigateway/simple-saml-idp-${local.environment}:*",
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group::log-stream:"
        ]
      },
      {
        Sid    = "CloudWatchLogsResourcePolicy"
        Effect = "Allow"
        Action = [
          "logs:ListTagsForResource",
          "logs:ListLogDeliveries",
          "logs:CreateLogDelivery",
          "logs:UpdateLogDelivery",
          "logs:DeleteLogDelivery",
          "logs:GetLogDelivery",
          "logs:PutResourcePolicy",
          "logs:DescribeResourcePolicies"
        ],
        Resource = [
          "*"
        ]
      },
      {
        Sid    = "IAMSAMLProviderManagement"
        Effect = "Allow"
        Action = [
          "iam:CreateSAMLProvider",
          "iam:TagSAMLProvider",
          "iam:GetSAMLProvider",
          "iam:ListSAMLProviders",
          "iam:DeleteSAMLProvider"
        ],
        Resource = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:saml-provider/*"
        ]
      },
      {
        Sid    = "IAMServiceLinkedRole"
        Effect = "Allow"
        Action = [
          "iam:CreateServiceLinkedRole"
        ],
        Resource = [
          "*"
        ]
      },
      {
        Sid    = "ResourceDiscovery"
        Effect = "Allow"
        Action = [
          "apigateway:GET",
          "lambda:ListFunctions",
          "lambda:GetFunctionCodeSigningConfig",
          "dynamodb:ListTables",
          "ssm:DescribeParameters",
          "s3:ListAllMyBuckets",
          "iam:ListRoles",
          "cloudfront:ListDistributions",
          "cloudfront:ListCloudFrontOriginAccessIdentities"
        ],
        Resource = [
          "*"
        ]
      },
    ]
  })
}