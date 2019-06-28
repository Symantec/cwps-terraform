# -----------------------------------------------------------------------------
# Required Variables
# -----------------------------------------------------------------------------

variable "name" {
  description = "The name of the DynamoDB Table."
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key."
}

variable "attribute" {
  type        = "list"
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes. "
}

variable "write_capacity" {
  description = "The number of write units for this table"
}

variable "read_capacity" {
  description = "The number of read units for this table"
}

# -----------------------------------------------------------------------------
# Optional Variables
# -----------------------------------------------------------------------------

variable "tags" {
  type    = "map"
  default = {}
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key."
  default     = ""
}

variable "global_secondary_index" {
  type        = "list"
  description = "Describe a GSO for the table; subject to the normal limits on the number of GSIs, projected attributes, etc."
  default     = []
}

variable "local_secondary_index" {
  type        = "list"
  description = "Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource."
  default     = []
}
