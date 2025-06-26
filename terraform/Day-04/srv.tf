provider "aws" {
  region = "us-east-1"
}

# Public key
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("srv-key.pub")
}

# create aws vpc
resource aws_default_vpc default {}

# Security group
resource "aws_security_group" "my_security_group" {
  name        = "srv-grp"
  description = "security group for the photo server"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "security-group"
  }
}

# EC2 instance
resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.my_key.key_name
  ami             = "ami-020cba7c55df1f615"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.my_security_group.name]
  user_data       = file("userdata.sh")

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "Tsrv"
  }
}

# Outputs
output "ec2_id" {
  value = aws_instance.my_instance.id
}

output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.my_instance.public_dns
}
