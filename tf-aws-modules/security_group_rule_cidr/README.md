# Security Group Rule - CIDR Block

## Usage

```hcl
module "<security group rule name>" {
  from_port         = "443"
  to_port           = "443"
  cidr_blocks       = ["10.0.0.0/8"]
  security_group_id = "sg-1234asdf"
  source            = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//security_group_rule_cidr"
}
```

## Required Variables

* `from_port`: The start port for the rule
* `to_port`: The end port for the rule
* `security_group_id`: The security group to associate with the rule
* `cidr_blocks`: A list of CIDR blocks to include with the rule

## Optional Variables

* `protocol`: The IP protocol to use for the rule. tcp, udp, icmp or the protocol number. Default is tcp
* `rule_type`: The type of rule. egress or ingress. Default is ingress

## Outputs

* `security_group_rule_id`: The Security Group Rule Id.

## Terraform Resources

* [aws_security_group_rule](https://www.terraform.io/docs/providers/aws/r/security_group_rule.html)
