# modules/ec2-instance/main.tf

resource "aws_instance" "this" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.bastion_instance_type
  subnet_id              = var.bastion_subnet_id
  vpc_security_group_ids = var.bastion_security_group_id
  key_name               = var.ec2_key_name
  iam_instance_profile   = var.ec2_iam_instance_profile
  monitoring             = var.enable_monitoring
  user_data              = var.user_data != null ? base64encode(var.user_data) : null
  # ← availability_zone removed

  tags = merge(
    var.common_tags,
    {
      Name = var.bastion_instance_name
    }
  )

  lifecycle {
    ignore_changes = [ami]
  }
}

# # Additional EBS volumes
# resource "aws_ebs_volume" "additional" {
#   count = length(var.additional_ebs_volumes)

#   availability_zone = aws_instance.this.availability_zone
#   size              = var.additional_ebs_volumes[count.index].size
#   type              = var.additional_ebs_volumes[count.index].type
#   encrypted         = var.additional_ebs_volumes[count.index].encrypted

#   tags = merge(
#     var.tags,
#     {
#       Name = "${var.name}-vol-${count.index}"
#     }
#   )
# }

# # Attach additional volumes to the instance
# resource "aws_volume_attachment" "additional" {
#   count = length(var.additional_ebs_volumes)

#   device_name = var.additional_ebs_volumes[count.index].device_name
#   volume_id   = aws_ebs_volume.additional[count.index].id
#   instance_id = aws_instance.this.id
# }