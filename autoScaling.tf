resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = var.ec2_image_id
  iam_instance_profile = aws_iam_instance_profile.ecs_agent.name
  security_groups      = [aws_security_group.private-security-group-ASG.id]
  user_data            = var.ec2_user_data
  instance_type        = var.ec2_instance_type
  key_name             = var.ec2_keypair_name
}

resource "aws_autoscaling_group" "failure_analysis_ecs_asg" {
  name                 = "ListApi-AG-ASE"
  vpc_zone_identifier  = [aws_subnet.prod-subnet-public-1.id, aws_subnet.prod-subnet-public-2.id]
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "EC2"
}

resource "aws_autoscaling_attachment" "autoscaling_group_association" {
  autoscaling_group_name = aws_autoscaling_group.failure_analysis_ecs_asg.id
  lb_target_group_arn    = aws_lb_target_group.hello_world.arn
}

resource "aws_autoscaling_policy" "autoscaling_policy_add_instance" {
  autoscaling_group_name = aws_autoscaling_group.failure_analysis_ecs_asg.name
  name                   = "Step_scaling_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
}

resource "aws_autoscaling_policy" "autoscaling_policy_terminate_intance" {
  autoscaling_group_name = aws_autoscaling_group.failure_analysis_ecs_asg.name
  name                   = "Step_scaling_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "autoscaling_policy_action_cpu_alarm_up" {
  alarm_name          = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.failure_analysis_ecs_asg.name}"
  }

  alarm_description = "Scale up by 1 instance if CPU threshold reaches 70% or above average"
  alarm_actions     = [aws_autoscaling_policy.autoscaling_policy_add_instance.arn]
}

resource "aws_cloudwatch_metric_alarm" "autoscaling_policy_action_cpu_alarm_down" {
  alarm_name          = "web_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.failure_analysis_ecs_asg.name}"
  }

  alarm_description = "Scale down by 1 instance if CPU threshold reaches 10% or lower average"
  alarm_actions     = [aws_autoscaling_policy.autoscaling_policy_terminate_intance.arn]
}
