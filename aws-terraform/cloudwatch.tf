# High CPU Utilization Alarm for EC2 Instances
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This alarm monitors EC2 CPU utilization"

  dimensions = {
    InstanceId = aws_instance.app_instance.id
  }

  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.sns_topic.arn]
  ok_actions          = [aws_sns_topic.sns_topic.arn]
  insufficient_data_actions = [aws_sns_topic.sns_topic.arn]
}

# Alarm for Monitoring RDS CPU Utilization
resource "aws_cloudwatch_metric_alarm" "rds_high_cpu" {
  alarm_name          = "rds-high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "This alarm monitors RDS CPU utilization"

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.app_db.id
  }

  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.sns_topic.arn]
}

# S3 Bucket Size Alarm
resource "aws_cloudwatch_metric_alarm" "s3_bucket_size" {
  alarm_name          = "s3-bucket-size"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "BucketSizeBytes"
  namespace           = "AWS/S3"
  period              = "86400"
  statistic           = "Average"
  threshold           = "5000000000"  # 5 GB
  alarm_description   = "This alarm monitors the size of S3 bucket"

  dimensions = {
    BucketName = aws_s3_bucket.logs.bucket
    StorageType = "StandardStorage"
  }

  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.sns_topic.arn]
}

# SNS Topic for Alarm Actions
resource "aws_sns_topic" "sns_topic" {
  name = "cloudwatch-alarms"
}

# Note: You'll also need to configure SNS subscriptions to actually receive the notifications
