resource "aws_default_vpc" "default" {}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0ceecbb0f30a902a6"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = file("user_data.sh")

  tags = {
    Name  = "WebS TF"
    Owner = "Andrew Belko"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "443 and 80 ports"
  vpc_id      = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Andrew Belko"
  }
}