terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.49.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  // profile = "default"
}

# Security group for EC2 instance
resource "aws_security_group" "webtraffic" {
  name        = "webtraffic"
  description = "Allow inbound and outbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = "Inbound Rule"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = "Outbound Rule"
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
# EC2 instance with remote-exec provisioner
resource "aws_instance" "ec2" {
  ami                    = "ami-04b70fa74e45c3917"
  instance_type          = "t2.micro"
  key_name               = "key-for-demo-3"
  vpc_security_group_ids = [aws_security_group.webtraffic.id]


  tags = {
    Name = "MyEc2Instance"
  }
  connection {
      type = "ssh"
      user = "chaitra"
      private_key = file("/home/chaitra/keys/demo/key-for-demo-3")
      host = aws_instance.ec2.public_ip
    }
}
 resource "aws_key_pair" "deployer"{
  key_name = "key-for-demo-3"
  public_key ="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCf2cLxKwuHCcyqRdrwBhzte7bGnaIMDEmfUcTLfLB5jMmB3CeYYJ+ocIyJpjabK/5QGW5vo9rsuWbH+W5zIUIBm3qrE+4kLTkfxi9u/TWrgsvlPRFDYYM+Y+h9bFhcZkSaYYKpMrAOWfzjjJMwTlGe8ZENxpTKwRlAVf1yXSSnGj5gUgd3CjzzdU6KfoHkBArB2C6TsPlEK1O+flBRCb7QqM6CnOxPi5cqEQ6JlqyCP86enKVn+0jlBMMuC5nZPSueal+8HSM/0QBKEr4Qs7pqlPaB/QJb0CHoLLY1K2bxXKmDac61XzGLckM11UUjMLBmBNpn0Yvay09xJsyBg6q/ chaitra@chaitra-VirtualBox"

 }
  
  
 
 
