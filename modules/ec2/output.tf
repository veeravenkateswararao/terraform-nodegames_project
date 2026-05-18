output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.terr_ec2.id
}

output "public_ip" {
  description = "EC2 Public IP"
  value       = aws_instance.terr_ec2.public_ip
}

output "private_ip" {
  description = "EC2 Private IP"
  value       = aws_instance.terr_ec2.private_ip
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.terr_sg.id
}

