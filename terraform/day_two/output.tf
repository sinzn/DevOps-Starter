
output "ec2_public_ip" {
	value = [
		for key in aws_instance.web : key.public_ip
	]
}
