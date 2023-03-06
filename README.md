# js-cloud💭
Personal Terraform configuration and related files

This project is a demo Terraform configuration (aws).  The config creates a VPC and a given number of ubuntu22.04 ec2 instances. Each instance installs apache web server and displays a web page with it's public IP.  This repo also includes a bash script that I wrote for looking up instance types across regions. 

This config is region-agnostic.  It automatically creates subnets and public route table associations (1 per available AZ in the given region).  The EC2 instances that get created are "round-robin'd" into the created subnets so that they are always distributed evenly 
amongst available AZs, irregardless of the region or number of instances you choose.

The config can be run by simply downloading this repo to a directory and $terraform apply (in that directory) will prompt you for the two required inputs- aws access key and secret access key.  The default number of instances it will create is 6, and the default region is us-east-1.  But changing these two values around (var.instance_count and var.aws_region) is the best way to see what the config will do.
