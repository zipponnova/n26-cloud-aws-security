resource "aws_cloudwatch_log_group" "ec2_log_group" {
  name              = "/aws/ec2/instance-logs"
  retention_in_days = 14
}

resource "aws_cloudwatch_metric_alarm" "instance_high_network" {
  alarm_name          = "instance-high-network"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "10000000"
  alarm_description   = "This alarm monitors EC2 network bandwidth usage"

  dimensions = {
    InstanceId = aws_instance.app_instance.id
  }

  actions_enabled = true
  alarm_actions   = [aws_sns_topic.sns_topic.arn]
}
