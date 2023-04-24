resource "aws_cloudwatch_metric_alarm" "EC2_CPU_Usage_Alarm" {
  alarm_name                = "EC2_CPU_Usage_Alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "70"
  alarm_description         = "This metric monitors ec2 cpu utilization exceeding 70%"

  insufficient_data_actions = []
  dimensions = {       
    InstanceId = aws_instance.inst1.id
    }
  alarm_actions = [aws_sns_topic.topic.arn]
  depends_on = [
    aws_sns_topic.topic,
    aws_sns_topic_subscription.email-target
    
]
}