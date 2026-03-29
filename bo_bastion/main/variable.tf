variable "region" {
  description = "AWS region to deploy the bastion host"
  type        = string
  default     = "ap-south-1"
}

# ── Tag Variables ──────────────────────────────────────────
variable "tag_CostCentre" {
  description = "Cost Centre tag value for resources"
  type        = string
  default     = ""
}

variable "tag_ApplicationId" {
  description = "Application ID tag value for resources"
  type        = string
  default     = ""
}

variable "tag_SupportGroup" {
  description = "Support group tag value for resources"
  type        = string
  default     = ""
}

variable "tag_Owner" {
  description = "Owner tag value for resources"
  type        = string                        # ← removed personal email default
}

variable "tag_AppCategory" {
  description = "App Category tag value for resources"
  type        = string
  default     = "B"                           # ← aligned with dev.tfvars
}

variable "tag_Environment" {
  description = "Environment tag value for resources"
  type        = string
  default     = "dev"                         # ← lowercase for consistency
}

# ── Network Variables ──────────────────────────────────────
variable "vpc_id" {
  description = "VPC ID for the bastion host"
  type        = string
}

variable "bastion_subnet_id" {
  description = "Subnet ID where bastion instance will be launched"
  type        = string
}

# ── EC2 Variables ──────────────────────────────────────────
variable "bastion_instance_name" {
  description = "Name of the bastion host instance"
  type        = string
  default     = "bastion-dev"
}

variable "bastion_ami_name" {
  description = "Name filter to find the bastion AMI"
  type        = string
  default     = "amzn2-ami-hvm-*-x86_64-gp2"
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "ec2_key_name" {
  description = "SSH key pair name for the bastion host"
  type        = string
  default     = null
}

variable "ec2_iam_instance_profile" {
  description = "IAM instance profile for the bastion host"
  type        = string
  default     = ""
}

variable "aws_root_account_id" {
  description = "AWS Root account ID"
  type        = string                        # ← added type and description
}