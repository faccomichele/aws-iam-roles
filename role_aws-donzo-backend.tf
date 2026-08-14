resource "aws_iam_role_policy_attachment" "administrator-access" {
  count      = contains(var.gha-roles, "aws-donzo-backend") ? 1 : 0
  role       = aws_iam_role.gha-role["aws-donzo-backend"].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
