# modules/security-group/variables.tf

variable "name" {
  description = "Name of the security group"
  type        = string
  default = "sg_bastion"
}

variable "securitygroup_name_placeholder" {
  description = "securitygroup name placeholder"
  default = "DEV_000"
  
}

variable "description" {
  description = "Description of the security group's purpose"
  type        = string
  default     = "Managed by Terraform"
}
variable "vpc_id" {
  description = "VPC ID where security group will be created"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "securitygroup_tooling_vpc" {
  description = "Name of the tooling VPC security group"
  type        = string
  default     = ""
}

variable "bastion_security_group_id" {
  description = "ID of the bastion security group"
  type        = string
  default     = ""
}
# Dynamic ingress rules - each rule is a map with port, protocol, and source
variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
    description     = optional(string, "")
  }))
  default = []
}

# Dynamic egress rules - defaults to allow all outbound
variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), [])
    security_groups = optional(list(string), [])
    description     = optional(string, "")
  }))
  default = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }]
}

variable "tags" {
  description = "Additional tags to apply"
  type        = map(string)
  default     = {}
}