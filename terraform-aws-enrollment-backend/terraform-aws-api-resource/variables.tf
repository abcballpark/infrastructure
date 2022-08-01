variable "name" {
  type = string
}

variable "api_name" {
  type = string
}

variable "api_id" {
  type = string
}

variable "parent_resource_id" {
  type = string
}

variable "authorizer_id" {
  type = string
}

# variable "dynamo_table_arn" {
#   type = string
# }

variable "table_attributes" {
    type = list(object({
        name = string,
        type = string
    }))
}

variable "hash_key" {
  type = string
}

variable "range_key" {
  type = string
}
