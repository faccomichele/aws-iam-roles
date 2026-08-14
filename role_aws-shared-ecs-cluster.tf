resource "aws_iam_role_policy" "aws-shared-ecs-cluster" {
  count = contains(var.gha-roles, "aws-shared-ecs-cluster") ? 1 : 0

  name = "aws-shared-ecs-cluster-inline"
  role = aws_iam_role.gha-role["aws-shared-ecs-cluster"].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ECSClusterDiscovery"
        Effect = "Allow"
        Action = [
          "ecs:ListClusters",
          "ecs:DescribeClusters",
          "ecs:DescribeCapacityProviders",
          "ecs:ListTagsForResource",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "ECSClusterManagement"
        Effect = "Allow"
        Action = [
          "ecs:CreateCluster",
          "ecs:DeleteCluster",
          "ecs:UpdateClusterSettings",
          "ecs:PutClusterCapacityProviders",
          "ecs:TagResource",
          "ecs:UntagResource",
        ]
        Resource = [
          "arn:aws:ecs:*:${data.aws_caller_identity.current.account_id}:cluster/aws-shared-ecs-cluster-${local.environment}-*",
        ]
      },
      {
        Sid    = "CloudWatchLogsDiscovery"
        Effect = "Allow"
        Action = [
          "logs:DescribeLogGroups",
          "logs:ListTagsForResource",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "CloudWatchLogsManagement"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:DeleteLogGroup",
          "logs:PutRetentionPolicy",
          "logs:DeleteRetentionPolicy",
          "logs:TagResource",
          "logs:UntagResource",
        ]
        Resource = [
          "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/ecs/aws-shared-ecs-cluster-${local.environment}-*",
        ]
      },
    ]
  })
}
