output "my_web_site_ip" {
  description = "IP address assigned to instance"
  value       = aws_instance.my_webserver.public_ip
}

output "my_instance_id" {
  description = "InstanceID"
  value       = aws_instance.my_webserver.id
}

output "my_instance_arn" {
  description = "InstanceARN"
  value       = aws_instance.my_webserver.arn
}

output "my_sg_id" {
  description = "SecurityGroup of our WebSite"
  value       = aws_security_group.my_webserver.id
}