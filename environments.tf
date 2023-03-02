terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}

resource "aws_instance" "salt_instance" {
  ami = "ami-0d50e5e845c552faf"
  instance_type = "t2.micro"
  count = var.instance_count
  tags = {
    Name = "salt_instance-${count.index}"
  }
}
