data "aws_ami" "myvm" { #This data block defines the target AMI
    most_recent = true #picks the most recent AMI
    owners = ["099720109477"] # Canonical
    filter { #block of filters to match the AMI
      name   = "name"
      values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-jammy-22.04-*"]
    }
    
    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }

    filter {
      name   = "architecture"
      values = ["x86_64"]
    }
}
