provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "my_key" {
  key_name   = "ec2-key"
  public_key = file("ec2-key.pub")
}

resource "aws_instance" "web" {
  ami           = "ami-020cba7c55df1f615" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  user_data = file("userdata.sh")

  tags = {
    Name = "docker-web"
  }

  vpc_security_group_ids = [aws_security_group.allow_http.id]
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open ssh"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
