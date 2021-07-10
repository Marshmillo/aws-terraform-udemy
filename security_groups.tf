resource "aws_segurity_group" "security_milo" {
    name = "allow_ssh_icmp"
    description = "Permitir ping y ssh"
    vpc_id = aws_vpc.milo_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_block = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Milo Security Group Terraform"
    }
}