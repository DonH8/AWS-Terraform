resource "aws_instance" "don_instance" {
    ami        = "ami-05c49a63441937596"  
    instance_type   = "t3.micro"


}

resource "aws_cloudwatch_metric_alarm" "example_alarm" {
  alarm_name          = "HighCPUUtilizationAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "70"  
  alarm_description   = "Alarm when CPU utilization is greater than 70%"
  alarm_actions       = ["arn:aws:sns:eu-north-1:888659321129:donCICDFailure"]  
  }