# Tags
tag_CostCentre    = "BusinessUnit-Platform"
tag_ApplicationId = "AL032"
tag_SupportGroup  = "AL032-Support"
tag_Owner         = "dl-al032-support@yourcompany.com"
tag_AppCategory   = "B"
tag_Environment   = "dev"

# Network
# ✅ Confirmed real values from earlier
vpc_id            = "vpc-xxxxxxxxxxx"
bastion_subnet_id = "subnet-xxxxxxxxx"  

# EC2
bastion_instance_name    = "bastion-dev"
bastion_instance_type    = "t3.micro"
ec2_key_name             = "bastion_key"
ec2_iam_instance_profile = "IAMPOLICYBASTION"
aws_root_account_id      = "xxxxxxxx"  