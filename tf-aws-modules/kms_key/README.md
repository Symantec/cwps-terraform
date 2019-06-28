# KMS Key

## Usage

```hcl
module "kms_key" {
  description = "Key to encrypt and decrypt data"
  policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Principal": "*",
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt"
      ]
      "Resource": "*"
    }
  ]
}
POLICY

  source = "git::https://github.allstate.com/cloud-engineering/tf-aws-modules.git//kms_key"
}
```

## Required Variables

* `description`: A description of the KMS Key
* `policy`: JSON policy document for the KMS Key

## Optional Variables

* `key_usage`: Specifies the intended use of the key. Default is ENCRYPT_DECRYPT
* `deletion_window_in_days`: Duration in days after which the key is deleted after resource destruction. Default is 30.
* `enable_key_rotation`: Enable or disable key rotation. Default is false.
* `kms_key_alias`: An alias for the KMS Key. Default is empty string
* `tags`: A map of tags to associate with the KMS Key.

## Outputs

* `kms_key_id`: The Id of the KMS Key
* `kms_key_arn`: The ARN of the KMS Key

## Terraform Resources

* [aws_kms_key](https://www.terraform.io/docs/providers/aws/r/kms_key.html)
