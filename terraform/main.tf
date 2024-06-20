resource "aws_security_group" "main" {
  name        = "main-security-group"
  description = "Security group for main application with minimal access"

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH access from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Web application access"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MainSecurityGroup"
  }
}


resource "aws_key_pair" "aws_key_ec2" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  aws_region = var.aws_region
  instance_type = var.instance_type
  ami_id = var.ami_id
  private_key_path = var.private_key_path
  public_key_path = var.public_key_path
  ssh_user = var.ssh_user
  script_path = "modules/ec2_instance/setup.sh"
  tags = var.tags
  key_name = aws_key_pair.aws_key_ec2.key_name 
  security_group_id = aws_security_group.main.id
}