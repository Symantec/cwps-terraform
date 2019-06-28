# -----------------------------------------------------------------------------
# Required Terraform Version
# -----------------------------------------------------------------------------

terraform {
  required_version = ">= 0.11.7"
}

# -----------------------------------------------------------------------------
# Resources
# -----------------------------------------------------------------------------

resource "aws_dynamodb_table" "table_wo_range_key" {
  count = "${var.range_key == "" ? 1 : 0}"

  name                   = "${var.name}"
  hash_key               = "${var.hash_key}"
  write_capacity         = "${var.write_capacity}"
  read_capacity          = "${var.read_capacity}"
  attribute              = ["${var.attribute}"]
  global_secondary_index = ["${var.global_secondary_index}"]
  local_secondary_index  = ["${var.local_secondary_index}"]

  tags = "${merge(map("Name", "${var.name}"), var.tags)}"
}

resource "aws_dynamodb_table" "table_w_range_key" {
  count = "${var.range_key == "" ? 0 : 1}"

  name                   = "${var.name}"
  hash_key               = "${var.hash_key}"
  range_key              = "${var.range_key}"
  write_capacity         = "${var.write_capacity}"
  read_capacity          = "${var.read_capacity}"
  attribute              = ["${var.attribute}"]
  global_secondary_index = ["${var.global_secondary_index}"]
  local_secondary_index  = ["${var.local_secondary_index}"]

  tags = "${merge(map("Name", "${var.name}"), var.tags)}"
}
