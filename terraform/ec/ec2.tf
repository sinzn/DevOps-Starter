# Create key pair
resource aws_key_pair my_key {
        key_name = "terraform-ec2-key"
        public_key = file("terraform-ec2-key.pub")
}

# create aws vpc
resource aws_default_vpc default {

}

# create Security group
resource aws_security_group my_security_group{
        name = "autmate-sg"
        description = "This will add a TF genrated security Group "
        vpc_id = aws_default_vpc.default.id

  # Inbound Rules
        ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open ssh"
  }

  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow http"
  }

  ingress{
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "photo node app"
  }

  # Outbound Rules
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
  }

  # Description for the ec2
  tags = {
    name = "securtiy group"
  }
}


resource "aws_instance" "my_instance"{
  key_name = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type = var.ec2_instance_type
  ami = var.ec2_ami_id

  root_block_device{
    volume_size = var.ec2_root_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = "terraformcreatedinstance"
  }
}
