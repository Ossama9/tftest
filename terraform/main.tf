data "aws_security_groups" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["main-security-group"]
  }
}

resource "aws_security_group" "main" {
  count = length(data.aws_security_groups.existing_sg.ids) == 0 ? 1 : 0

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
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MainSecurityGroup"
  }
}

module "ec2_instance" {
  source              = "./modules/ec2_instance"
  aws_region          = var.aws_region
  instance_type       = var.instance_type
  ami_id              = var.ami_id
  key_name            = var.key_name
  ssh_user            = var.ssh_user
  private_key_path =  var.private_key_path
  script_path         = var.script_path
  tags                = var.tags
  security_group_id   = length(data.aws_security_groups.existing_sg.ids) > 0 ? data.aws_security_groups.existing_sg.ids[0] : aws_security_group.main[0].id
}
