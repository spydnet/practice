resource "aws_instance" "Terraform" {
  count = 3
  ami = "ami-0ceecbb0f30a902a6"
  instance_type = "t1.micro"
}