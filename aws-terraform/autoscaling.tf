resource "aws_launch_configuration" "app_lc" {
  name          = "app-launch-configuration"
  image_id      = "ami-12345678"  # Update AMI ID
  instance_type = var.instance_type
  key_name      = "your-key-pair-name"  # Update key name

  security_groups = [aws_security_group.app_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  launch_configuration    = aws_launch_configuration.app_lc.id
  vpc_zone_identifier     = [aws_subnet.app_subnet.id]
  max_size                = 5
  min_size                = 2
  desired_capacity        = 3
  health_check_type       = "ELB"
  health_check_grace_period = 300
  force_delete            = true
  target_group_arns       = [aws_lb_target_group.app_lb_tg.arn]

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}
