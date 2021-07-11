# create autoscaling target-tracking-policy
resource "aws_autoscaling_policy" "target-tracking-policy" {
  name                   = "target-tracking-policy"
  policy_type            = "TargetTrackingScaling" 
   
  #estimated_instance_warmup : CloudWatch 지표를 제공 할 때까지의 예상 시간 
  estimated_instance_warmup = 60
  autoscaling_group_name = aws_autoscaling_group.tf-asg.name

    target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0 
  }  
}
