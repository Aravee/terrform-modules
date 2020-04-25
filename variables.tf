variable "domain_names" {
  type = "list"
}

variable "tags" {
  type = "map"
}

variable "hosted_zone_id" {
  type = "string"
}

variable "validation_record_ttl" {
  default = 60
}
