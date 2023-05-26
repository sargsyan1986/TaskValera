# resource "aws_cloudwatch_dashboard" "dashboard-terraform" {
#   dashboard_name = "terra-cloudwatch-dashboard-1"

#   dashboard_body = <<EOF
# {
#   "widgets": [
#     {
#       "type": "metric",
#       "x": 0,
#       "y": 0,
#       "width": 12,
#       "height": 6,
#       "properties": {
#         "metrics": [
#           [
#             "CWAgent",
#             "disk_used_percent",
#             "InstanceId",
#             "${aws_instance.inst1.id}",
#             "path",
#              "/",
#             "device",
#             "xvda1",
#             "fstype",
#             "xfs"
#           ]
#         ],
#         "period": 180,
#         "stat": "Average",
#         "region": "us-east-1",
#         "stacked": true,
#         "title": "EC2 Instance Disk Used"
#       }
#     }


#   ]
# }
# EOF

# }

# resource "aws_cloudwatch_metric_alarm" "cwma" {
#   alarm_name          = "helav"
#   alarm_description   = "This metric monitors ec2 cpu utilization"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = 120
#   evaluation_periods  = 2
#   datapoints_to_alarm = 2
#   statistic           = "Maximum"
#   threshold           = 75
#   alarm_actions       = [aws_sns_topic.topic.arn]
#   dimensions = {
#     instanceId = aws_instance.inst1.id
#   }
# }

resource "aws_cloudwatch_metric_alarm" "cwma" {
  alarm_name                = "CPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions             = [aws_sns_topic.topic.arn]
  insufficient_data_actions = []
  dimensions = {
    InstanceId = aws_instance.inst1.id
  }
}

resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = "terraform-test-foobar5"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "disk_used_percent"
  namespace                 = "CWAgent"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "40"
  alarm_description         = "This metric monitors ec2 disk utilization"
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.topic.arn]
  insufficient_data_actions = []
  #treat_missing_data = "notBreaching"

  dimensions = {
    path       = "/"
    InstanceId = aws_instance.inst1.id
    device     = "xvda1"

    fstype = "xfs"


  }
  # depends_on = [
  #   aws_sns_topic.topic,
  #   aws_sns_topic_subscription.email-target
  # ]
}
