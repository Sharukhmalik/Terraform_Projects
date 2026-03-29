# modules/security-group/outputs.tf
output "id" {
  description = "The ID of the security group"
  value       = aws_security_group.this.id
}

output "arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.this.arn
}

output "name" {
  description = "The name of the security group"
  value       = aws_security_group.this.name
}

# ✅ Add this
output "bastion_security_group_id" {
  description = "The ID of the bastion security group"
  value       = aws_security_group.this.id
}