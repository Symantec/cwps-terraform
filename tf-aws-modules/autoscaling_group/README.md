# AutoScaling Group

## Usage

```hcl
module "ec2_autoscaling_group" {
  name                    = "ec2-autoscaling-group"
  launch_configuration_id = "lc123467998"
  vpc_zone_identifier     = ["subnet-asdf1234", "subnet-1234adsf"]
  source                  = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//autoscaling_group"
}
```

## Required Variables

* `name`: The Name for the AutoScaling Group
* `launch_configuration_id`: The Launch Configuration for the AutoScaling Group
* `vpc_zone_identifier`: A list of Subnets Ids to launch resources in.

## Optional Variables

* `desired_capacity`: The desired capacity for the AutoScaling Group. Default is 1
* `health_check_grace_period`: The health check grace period for the AutoScaling Group. Default is 30.
* `health_check_type`: The health check type for the AutoScaling Group. Default is EC2
* `max_size`: The maximum size for the AutoScaling Group. Default is 2
* `min_size`: The minimum size for the AutoScaling Group. Default is 1
* `default_cooldown`: The amount of time in seconds after a scaling activity before another one will be performed. Default is 300
* `load_balancers`: A list of load balancers to add to the AutoScaling Group. Default is an empty list.
* `target_group_arns`: A list of target group ARNs to register from the AutoScaling Group. Default is an empty list.
* `asg_tags`: A list of tags to apply to instances in the AutoScaling Group. Default is an empty list.
* `enabled_metrics`: List of metrics to collect. Default is an empty list: `[]`
  * GroupMinSize
  * GroupMaxSize
  * GroupDesiredCapacity
  * GroupInServiceInstances
  * GroupPendingInstances
  * GroupStandbyInstances
  * GroupTerminatingInstances
  * GroupTotalInstances


## Outputs

* `name`: The Name for the AutoScaling Group
* `id`: The Id for the AutoScaling Group
* `arn`: The ARN for the AutoScaling Group

## Terraform Resources

* [aws_autoscaling_group](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html)
