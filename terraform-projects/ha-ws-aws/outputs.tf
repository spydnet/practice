output "web_loadbalancer_url" {
  value = aws_elb.my_webserver.dns_name
}