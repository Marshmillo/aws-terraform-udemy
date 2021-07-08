resource "aws_instance" "milo_instance" {
  ami = "ami-0ab4d1e9cf9a1215a"
  instance_type = "t2.micro"
}