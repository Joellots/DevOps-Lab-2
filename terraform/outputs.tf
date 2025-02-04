output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.cerebro-server-instance.id
}

output "instance_public_ip" {
  description = "EC2 instance IP (public)"
  value       = aws_instance.cerebro-server-instance.public_ip
}

output "instance_dns" {
  description = "EC2 instance DNS"
  value       = aws_instance.cerebro-server-instance.public_dns
}