resource "aws_instance" "mypublicvm" { #Actual instance block
  ami           = data.aws_ami.myvm.id #References the ami defined above
  instance_type = var.instance_type #References the instance type, either t2-micro
  subnet_id     = var.subnet-id #passed from variable
  associate_public_ip_address = var.associate-public-ip #
  vpc_security_group_ids = [var.sg-id] #
  key_name = var.access-key-name #

  root_block_device {
    encrypted   = true
  }

  metadata_options {
    http_tokens   = "required"    # Enforce IMDSv2
    http_endpoint = "enabled"     # Keep metadata service accessible
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
  
#   tags = merge(
#     var.common_tags,
#     { Name = "emart-cluster-igw" }
#   )
}
