resource "aws_iam_role" "gha-role" {
  for_each = toset(var.gha-roles)

  name_prefix        = "${each.key}-${local.environment}-GHARole-"
  assume_role_policy = local.gha_common_assume_policy[each.key]
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "terraform-common" {
  for_each = local.common_role_policy_attachments

  role       = aws_iam_role.gha-role[each.value.role_name].name
  policy_arn = each.value.policy_arn
}
