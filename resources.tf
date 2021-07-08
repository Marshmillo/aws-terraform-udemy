resource "aws_vpc" "milo_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    
    tags = {
        Name = "Milo VPC Terraform"
    }
}

resource "aws_subnet" "subnet_milo" {
    vpc_id = aws_vpc.milo_vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"

    tags = {
        Name = "Milo Subnet Terraform"
    }
}

#resource "aws_instance" "milo_instance" {
#  ami = "ami-0ab4d1e9cf9a1215a"
#  instance_type = "t2.micro"
#}