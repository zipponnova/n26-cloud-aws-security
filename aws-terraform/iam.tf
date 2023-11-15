# IAM Role for EC2 Instances
resource "aws_iam_role" "app_role" {
  name = "app_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "app-role"
  }
}

# IAM Policy for Application
resource "aws_iam_policy" "app_policy" {
  name        = "app_policy"
  description = "A policy for the application to access specific resources"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          // Add other required permissions here
        ],
        Effect = "Allow",
        Resource = [
          "${aws_s3_bucket.logs.arn}/*",
          // Include other resources as required
        ]
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      // Add additional statements as necessary
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "app_policy_attach" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.app_policy.arn
}

# IAM Instance Profile for EC2 Instances
resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "app_instance_profile"
  role = aws_iam_role.app_role.name
}
