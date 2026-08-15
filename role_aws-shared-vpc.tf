resource "aws_iam_role_policy" "aws-shared-vpc" {
  count = contains(var.gha-roles, "aws-shared-vpc") ? 1 : 0

  name = "aws-shared-vpc-inline"
  role = aws_iam_role.gha-role["aws-shared-vpc"].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EC2NetworkDiscovery"
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeEgressOnlyInternetGateways",
          "ec2:DescribeSubnets",
          "ec2:DescribeRouteTables",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSecurityGroupRules",
          "ec2:DescribeTags",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeAddresses",
          "ec2:DescribeDhcpOptions",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:DescribeNatGateways",
          "ec2:DescribeRegions",
          "ec2:DescribeFlowLogs",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "EC2NetworkCreate"
        Effect = "Allow"
        Action = [
          "ec2:CreateVpc",
          "ec2:CreateInternetGateway",
          "ec2:CreateEgressOnlyInternetGateway",
          "ec2:CreateSubnet",
          "ec2:CreateRouteTable",
          "ec2:CreateNetworkAcl",
          "ec2:CreateTags",
        ]
        Resource = ["*"]
        Condition = {
          StringEquals = {
            "aws:RequestTag/Project" = "aws-shared-vpc"
          }
        }
      },
      {
        Sid    = "EC2NetworkManagement"
        Effect = "Allow"
        Action = [
          "ec2:DeleteVpc",
          "ec2:ModifyVpcAttribute",
          "ec2:AttachInternetGateway",
          "ec2:DetachInternetGateway",
          "ec2:DeleteInternetGateway",
          "ec2:DeleteEgressOnlyInternetGateway",
          "ec2:DeleteSubnet",
          "ec2:ModifySubnetAttribute",
          "ec2:AssociateSubnetCidrBlock",
          "ec2:DisassociateSubnetCidrBlock",
          "ec2:DeleteRouteTable",
          "ec2:AssociateRouteTable",
          "ec2:DisassociateRouteTable",
          "ec2:ReplaceRouteTableAssociation",
          "ec2:CreateRoute",
          "ec2:DeleteRoute",
          "ec2:ReplaceRoute",
          "ec2:DeleteNetworkAcl",
          "ec2:CreateNetworkAclEntry",
          "ec2:DeleteNetworkAclEntry",
          "ec2:ReplaceNetworkAclEntry",
          "ec2:ReplaceNetworkAclAssociation",
          "ec2:DisassociateNetworkAcl",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:DeleteTags",
        ]
        Resource = ["*"]
        Condition = {
          StringEquals = {
            "aws:ResourceTag/Project" = "aws-shared-vpc"
          }
        }
      },
      {
        Sid    = "EC2FlowLogs"
        Effect = "Allow"
        Action = [
          "ec2:CreateFlowLogs",
          "ec2:DeleteFlowLogs",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "ECSClusterDiscovery"
        Effect = "Allow"
        Action = [
          "ecs:ListClusters",
          "ecs:DescribeClusters",
        ]
        Resource = [
          "*",
          "arn:aws:ecs:*:${data.aws_caller_identity.current.account_id}:cluster/*",
        ]
      },
      {
        Sid    = "AutoScalingDescribe"
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeTags",
          "autoscaling:DescribeAutoScalingGroups",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "S3LoggingBucketManagement"
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:GetBucketAcl",
          "s3:PutBucketAcl",
          "s3:GetBucketCORS",
          "s3:PutBucketCORS",
          "s3:DeleteBucketCORS",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "s3:DeleteBucketPolicy",
          "s3:GetBucketPublicAccessBlock",
          "s3:PutBucketPublicAccessBlock",
          "s3:GetBucketTagging",
          "s3:PutBucketTagging",
          "s3:DeleteBucketTagging",
          "s3:GetBucketVersioning",
          "s3:PutBucketVersioning",
          "s3:GetEncryptionConfiguration",
          "s3:PutEncryptionConfiguration",
          "s3:DeleteEncryptionConfiguration",
          "s3:GetLifecycleConfiguration",
          "s3:PutLifecycleConfiguration",
          "s3:DeleteLifecycleConfiguration",
          "s3:GetBucketOwnershipControls",
          "s3:PutBucketOwnershipControls",
          "s3:GetBucketLogging",
          "s3:PutBucketLogging",
          "s3:GetBucketRequestPayment",
          "s3:PutBucketRequestPayment",
          "s3:GetBucketWebsite",
          "s3:PutBucketWebsite",
          "s3:DeleteBucketWebsite",
          "s3:GetBucketNotification",
          "s3:PutBucketNotification",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetAccelerateConfiguration",
          "s3:PutAccelerateConfiguration",
          "s3:GetReplicationConfiguration",
          "s3:ListBucket",
          "s3:ListBucketVersions",
          "s3:ListBucketMultipartUploads",
          "s3:AbortMultipartUpload",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:GetObjectAcl",
          "s3:PutObjectAcl",
          "s3:GetObjectTagging",
          "s3:PutObjectTagging",
          "s3:ListTagsForResource",
          "s3:TagResource",
          "s3:UntagResource",
        ]
        Resource = [
          "arn:aws:s3:::aws-shared-vpc-flow-logs-${local.environment}-*",
          "arn:aws:s3:::aws-shared-vpc-flow-logs-${local.environment}-*/*",
        ]
      },
      {
        Sid    = "Route53ResolverQueryLogs"
        Effect = "Allow"
        Action = [
          "route53resolver:CreateResolverQueryLogConfig",
          "route53resolver:ListResolverQueryLogConfigs",
          "route53resolver:ListResolverQueryLogConfigAssociations",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "Route53ResolverQueryLogsResourceScoped"
        Effect = "Allow"
        Action = [
          "route53resolver:DeleteResolverQueryLogConfig",
          "route53resolver:GetResolverQueryLogConfig",
          "route53resolver:AssociateResolverQueryLogConfig",
          "route53resolver:DisassociateResolverQueryLogConfig",
          "route53resolver:GetResolverQueryLogConfigAssociation",
          "route53resolver:TagResource",
          "route53resolver:UntagResource",
          "route53resolver:ListTagsForResource",
        ]
        Resource = [
          "arn:aws:route53resolver:*:${data.aws_caller_identity.current.account_id}:resolver-query-log-config/*",
          "arn:aws:route53resolver:*:${data.aws_caller_identity.current.account_id}:resolver-query-log-config-association/*",
        ]
      },
      {
        Sid    = "GuardDutyDetectorManagement"
        Effect = "Allow"
        Action = [
          "guardduty:CreateDetector",
          "guardduty:ListDetectors",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "GuardDutyDetectorOperations"
        Effect = "Allow"
        Action = [
          "guardduty:UpdateDetector",
          "guardduty:DeleteDetector",
          "guardduty:GetDetector",
          "guardduty:UpdateDetectorFeature",
          "guardduty:TagResource",
          "guardduty:UntagResource",
          "guardduty:ListTagsForResource",
        ]
        Resource = [
          "arn:aws:guardduty:*:${data.aws_caller_identity.current.account_id}:detector/*",
        ]
      },
      {
        Sid    = "GlueCatalogManagement"
        Effect = "Allow"
        Action = [
          "glue:CreateDatabase",
          "glue:UpdateDatabase",
          "glue:DeleteDatabase",
          "glue:GetDatabase",
          "glue:GetDatabases",
          "glue:CreateTable",
          "glue:DeleteTable",
          "glue:UpdateTable",
          "glue:GetTable",
          "glue:GetTables",
        ]
        Resource = [
          "arn:aws:glue:*:${data.aws_caller_identity.current.account_id}:catalog",
          "arn:aws:glue:*:${data.aws_caller_identity.current.account_id}:database/aws_shared_vpc_logging",
          "arn:aws:glue:*:${data.aws_caller_identity.current.account_id}:table/aws_shared_vpc_logging/*",
        ]
      },
      {
        Sid    = "AthenaWorkgroupManagement"
        Effect = "Allow"
        Action = [
          "athena:CreateWorkGroup",
          "athena:DeleteWorkGroup",
          "athena:GetWorkGroup",
          "athena:UpdateWorkGroup",
          "athena:ListWorkGroups",
          "athena:TagResource",
          "athena:UntagResource",
          "athena:ListTagsForResource",
        ]
        Resource = [
          "arn:aws:athena:*:${data.aws_caller_identity.current.account_id}:workgroup/aws-shared-vpc-logging",
        ]
      },
      {
        Sid    = "IAMServiceLinkedRole"
        Effect = "Allow"
        Action = [
          "iam:CreateServiceLinkedRole",
        ]
        Resource = [
          "arn:aws:iam::*:role/aws-service-role/vpc-flow-logs.amazonaws.com/AWSServiceRoleForVPCFlowLogs",
          "arn:aws:iam::*:role/aws-service-role/guardduty.amazonaws.com/AWSServiceRoleForAmazonGuardDuty",
        ]
      },
    ]
  })
}
