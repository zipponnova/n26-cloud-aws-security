resource "aws_iam_policy" "rds_policy" {
  name        = "rds_policy"
  description = "Policy for RDS management"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "rds:*",
        ],
        Effect = "Allow",
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name        = "s3_policy"
  description = "Policy for S3 access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:*",
        ],
        Effect = "Allow",
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_policy_attach" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.rds_policy.arn
}

resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}
