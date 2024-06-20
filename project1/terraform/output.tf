output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "jenkins_url" {
  description = "URL for accessing Jenkins"
  value       = "http://${aws_instance.ec2.public_ip}:8080"
}
