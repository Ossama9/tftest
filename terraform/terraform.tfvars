# AWS Region where resources will be created
aws_region = "eu-west-3"

# EC2 instance type
instance_type = "t2.micro"

# AMI ID for the EC2 instance
ami_id = "ami-087da76081e7685da"


# SSH username for the EC2 instance connection
ssh_user = "admin"

tags             = {
    Name        = "MyInstance"
    Environment = "Development"
  }