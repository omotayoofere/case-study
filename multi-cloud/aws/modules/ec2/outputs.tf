output "ec2-ips" {
    value = aws_instance.mypublicvm.public_ip
}