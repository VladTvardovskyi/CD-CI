variable "cidr_vpc" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = ""
}
variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}
variable "cidr_subnet_public" {
  description = "The CIDR block for the Public Subnet"
  type        = string
  default     = ""
}
variable "cidr_subnet_private" {
  description = "The CIDR block for the Private Subnet"
  type        = string
  default     = ""
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_classiclink" {
  description = "Should be true to enable ClassicLink for the VPC."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = string
  default     = "Vpc-custom-demo"
}
