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
          "ec2:DescribeSecurityGroupRules",
        ]
        Resource = ["*"]
      },
      {
        Sid    = "EC2NetworkManagement"
        Effect = "Allow"
        Action = [
          "ec2:CreateVpc",
          "ec2:DeleteVpc",
          "ec2:ModifyVpcAttribute",
          "ec2:CreateInternetGateway",
          "ec2:AttachInternetGateway",
          "ec2:DetachInternetGateway",
          "ec2:DeleteInternetGateway",
          "ec2:CreateEgressOnlyInternetGateway",
          "ec2:DeleteEgressOnlyInternetGateway",
          "ec2:CreateSubnet",
          "ec2:DeleteSubnet",
          "ec2:ModifySubnetAttribute",
          "ec2:CreateRouteTable",
          "ec2:DeleteRouteTable",
          "ec2:AssociateRouteTable",
          "ec2:DisassociateRouteTable",
          "ec2:ReplaceRouteTableAssociation",
          "ec2:CreateRoute",
          "ec2:DeleteRoute",
          "ec2:ReplaceRoute",
          "ec2:CreateNetworkAcl",
          "ec2:DeleteNetworkAcl",
          "ec2:CreateNetworkAclEntry",
          "ec2:DeleteNetworkAclEntry",
          "ec2:ReplaceNetworkAclEntry",
          "ec2:ReplaceNetworkAclAssociation",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:CreateTags",
          "ec2:DeleteTags",
        ]
        Resource = ["*"]
        # Condition = {
        #   StringLike = {
        #     "aws:ResourceTag/Name" = "aws-shared-vpc-${local.environment}-*"
        #   }
        # }
      },
    ]
  })
}
