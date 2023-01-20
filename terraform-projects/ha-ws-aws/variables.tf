variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t3.small"
}


variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list
  default     = ["80", "443"]
}


variable "common_tags" {
  description = "Common Tags"
  type        = map
  default = {
    Owner       = "Andrew Belko"
    Project     = "Test"
    CostCenter  = "12345"
    Environment = "Stage"
  }
}