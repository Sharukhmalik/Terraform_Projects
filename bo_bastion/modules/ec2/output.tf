output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "Private IP address of the instance"
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IP address if assigned"
  value       = aws_instance.this.public_ip
}

output "arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.this.arn
}

output "availability_zone" {
  description = "Availability zone of the instance"
  value       = aws_instance.this.availability_zone
}