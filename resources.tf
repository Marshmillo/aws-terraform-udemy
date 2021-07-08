resource "aws_vpc" "milo_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    
    tags = {
        Name = "Milo VPC Terraform"
    }
}

#resource "aws_instance" "milo_instance" {
#  ami = "ami-0ab4d1e9cf9a1215a"
#  instance_type = "t2.micro"
#}