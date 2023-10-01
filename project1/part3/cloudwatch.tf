////////////////////////////////////////////////////////////////////
# CloudWatch Alarms for Auto Scaling based on SQS Queue Length
////////////////////////////////////////////////////////////////////

resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "scale_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"                                  // visible messages exceeds 3 for 2 consecutive periods of 1 minutes
  metric_name         = "ApproximateNumberOfMessagesVisible" // the metric for the number of messages in the SQS queue
  namespace           = "AWS/SQS"                            //  the namespace for Amazon SQS in CloudWatch
  period              = "60"                                 // periods of 1 minutes
  statistic           = "Average"
  threshold           = "3" // set the threshold for 2 consecutive periods

  dimensions = {
    QueueName = aws_sqs_queue.terraform_queue.name
  }

  alarm_description = "This metric triggers an alarm when the average number of visible messages exceeds 2 for 2 consecutive periods of 1 minutes."
  alarm_actions     = [aws_autoscaling_policy.scale_up.arn]
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1 // number of instances
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.name
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = "120"
  statistic           = "Average"
  threshold           = "2" // set the threshold as per your need

  dimensions = {
    QueueName = aws_sqs_queue.terraform_queue.name
  }

  alarm_description = "This metric triggers an alarm when the average number of visible messages is below 2 for 2 consecutive periods of 2 minutes."
  alarm_actions     = [aws_autoscaling_policy.scale_down.arn]
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -1 // number of instances
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.name
}
