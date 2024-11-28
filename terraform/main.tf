terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "lab6.7-my-tf-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-lab6-tf-table"
  }
}

provider "aws" {
  region = "us-east-1"
}

# Data for existing security group
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

# Create a new security group if it doesn't exist
resource "aws_security_group" "web_app" {
  count       = length(data.aws_security_group.existing_web_app.id) > 0 ? 0 : 1
  name        = "web_app"
  description = "Security group for web app"

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

# Create an EC2 instance
resource "aws_instance" "webapp_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  security_groups = ["web_app"]

  tags = {
    Name = "webapp_instance"
  }
}

# Output the public IP of the instance
output "instance_public_ip" {
  value     = aws_instance.webapp_instance.public_ip
  sensitive = true
}
