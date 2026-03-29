output "tooling_vpc_ids" {
    value = data.aws_vpc.tooling_vpc.id
  
}

output "tooling_subnet_a_id" {
    value = data.aws_subnet.tooling_subnet_a.id
  
}



output "tooling_subnet_az_a" {
    value = data.aws_subnet.tooling_subnet_a.availability_zone
  
}



output "tooling_subnet_b_id" {
    value = data.aws_subnet.tooling_subnet_b.id
  
}



output "tooling_subnet_az_b" {
    value = data.aws_subnet.tooling_subnet_b.availability_zone
  
}


output "tooling_subnet_c_id" {
    value = data.aws_subnet.tooling_subnet_c.id
  
}


output "bastion_security_group_id" {
    value = module.sg.bastion_security_group_id
  
}



output "bastion_id" {
  description = "ID of the bastion EC2 instance"
  value       = module.ec2.instance_id    # ← updated to match ec2 output name
}


