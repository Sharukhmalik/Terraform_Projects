module "sg" {
  source      = "../modules/sg"
  vpc_id      = var.vpc_id          # ← required, was missing
  common_tags = local.common_tags   # ← use local not var
}

module "ec2" {
  source                    = "../modules/ec2"
  bastion_ami_name          = var.bastion_ami_name
  bastion_instance_name     = var.bastion_instance_name
  bastion_instance_type     = var.bastion_instance_type
  bastion_subnet_id         = var.bastion_subnet_id
  bastion_security_group_id = [module.sg.id]
  ec2_key_name              = var.ec2_key_name
  ec2_iam_instance_profile  = var.ec2_iam_instance_profile
  common_tags               = local.common_tags
  aws_root_account_id       = var.aws_root_account_id    # ← add this
}