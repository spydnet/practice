resource "aws_default_vpc" "default" {}

data "aws_availability_zones" "available" {}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "my_webserver" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = var.allow_ports
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
  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Security group by Terraform" })
}

resource "aws_launch_configuration" "my_webserver" {
  name_prefix     = "web-server-ha-"
  image_id        = data.aws_ami.latest_amazon_linux.image_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.my_webserver.id]
  user_data       = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_webserver" {
  name                 = "ASG-${aws_launch_configuration.my_webserver.name}"
  launch_configuration = aws_launch_configuration.my_webserver.name
  min_size             = "2"
  max_size             = "2"
  min_elb_capacity     = "2"
  vpc_zone_identifier  = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.my_webserver.name]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_elb" "my_webserver" {
  name               = "web-server-ha-elb"
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  security_groups    = [aws_security_group.my_webserver.id]
  listener {
    lb_port           = "80"
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Load Balancer by Terraform" })
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}