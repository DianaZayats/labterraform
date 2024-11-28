terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region     = "us-east-1"
}

data "aws_security_group" "existing_web_app" {
  filter {
    name   = "group-name"
    values = ["web_app"]
  }

  filter {
    name   = "vpc-id"
    values = ["vpc-0afc3b8b4822b144c"]
  }
}

resource "aws_security_group" "web_app" {
  count       = length(data.aws_security_group.existing_web_app.id) > 0 ? 0 : 1
  name        = "web_app"
  description = "security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_app"
  }
}

resource "aws_instance" "webapp_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  security_groups= ["web_app"]
  tags = {
    Name = "webapp_instance"
  }
}

output "instance_public_ip" {
  value     = aws_instance.webapp_instance.public_ip
  sensitive = true
}