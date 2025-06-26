provider "aws"{
    region = "us-east-1"
}

resource "aws_key_pair" "srv_key"{
    key_name = "srv-key"
    public_key = file("srv-key.pub")
}

resource aws_default_vpc default {}

resource "aws_security_group" "mera_sg"{
    name = "security_group"
    description = "humara wala security group used for deployment"
    vpc_id = aws_default_vpc.default.id

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow http in security group" 
    }
    
    ingress{
        from_port = 22
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "tcp"
        description = "Allow ssh in security group" 
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow ssh in security group" 
    }
}

resource "aws_instance" "mera_tera"{
    instance_type = "t2.micro"
    ami = "ami-020cba7c55df1f615"
    key_name = aws_key_pair.srv_key.key_name
    user_data = file("userdata.sh")
    vpc_security_group_ids = [aws_security_group.mera_sg.id]

    root_block_device{
        volume_size = 8
        volume_type = "gp3"
    }

    tags = {
        Name = "Terrafom-ghoda"
    }
}

output "instance_id" {
  value = aws_instance.mera_tera.id
}

output "ec2_public_ip"{
  value = aws_instance.mera_tera.public_ip
}
