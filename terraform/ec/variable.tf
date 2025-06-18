variable "ec2_instance_type"{
  default = "t2.micro"
  type = string
}
variable "ec2_root_storage_size"{
        default = 15
        type = number
}

variable "ec2_ami_id"{
        default = "ami-020cba7c55df1f615"
        type = string
}

variable "ec2_instance_name"{
        default = "terraform-az"
  type = string
}
