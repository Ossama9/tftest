# AWS Region where resources will be created
aws_region = "eu-west-3"

# EC2 instance type
instance_type = "t2.micro"

# AMI ID for the EC2 instance
ami_id = "ami-087da76081e7685da"

# Local path to the private SSH key
private_key_path = "/Users/ossama/.ssh/id_rsa"

# Public key for AWS Key Pair
public_key_path = "/Users/ossama/.ssh/id_rsa.pub"

# SSH username for the EC2 instance connection
ssh_user = "admin"

tags             = {
    Name        = "MyInstance"
    Environment = "Development"
  }