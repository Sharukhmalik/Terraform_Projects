# modules/ec2-instance/variables.tf

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1" # Set a default region
}


variable "bastion_instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = ""
}

variable "bastion_ami_name" {
  type    = string
  default = "amzn2-ami-hvm-*-x86_64-gp2"
}


variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "bastion_instance_type" {
  type    = string
  default = "t3.micro"
}
# variable "ami_id" {
#   description = "Specific AMI ID. If not set, latest Amazon Linux 2023 is used."
#   type        = string
#   default     = null
# }

variable "bastion_subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "bastion_security_group_id" {
  type    = list(string)   # ← expects a list
  default = []
}

variable "ec2_key_name" {
  description = "SSH key pair name. Set to null to disable SSH key."
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script to run on first boot"
  type        = string
  default     = null
}

variable "ec2_iam_instance_profile" {
  description = "Name of the IAM instance profile to attach"
  type        = string
  default     = null
}

# variable "root_volume_size" {
#   description = "Root EBS volume size in GB"
#   type        = number
#   default     = 20
# }

# variable "root_volume_type" {
#   description = "Root EBS volume type"
#   type        = string
#   default     = "gp3"
# }

# variable "additional_ebs_volumes" {
#   description = "Additional EBS volumes to attach"
#   type = list(object({
#     device_name = string
#     size        = number
#     type        = optional(string, "gp3")
#     encrypted   = optional(bool, true)
#   }))
#   default = []
# }

# variable "associate_public_ip" {
#   description = "Whether to associate a public IP address"
#   type        = bool
#   default     = false
# }



variable "aws_root_account_id" {
  description = "AWS Root account ID"
  type        = string
}
variable "enable_monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}