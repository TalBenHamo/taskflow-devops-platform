output "instance_id" {
  description = "TaskFlow EC2 instance ID"
  value       = aws_instance.taskflow.id
}

output "public_ip" {
  description = "Public IP address of the TaskFlow server"
  value       = aws_instance.taskflow.public_ip
}

output "public_dns" {
  description = "Public DNS name of the TaskFlow server"
  value       = aws_instance.taskflow.public_dns
}

output "ssh_command" {
  description = "Command used to connect to the TaskFlow server"
  value       = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.taskflow.public_ip}"
}
