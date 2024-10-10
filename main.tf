terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

# Create a spread placement group (compatible with all instance types)
resource "aws_placement_group" "app_cluster" {
  name     = "app-cluster"
  strategy = "spread"
}

# Create an EC2 instance and assign it to the placement group
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"
  placement_group = aws_placement_group.app_cluster.name

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
