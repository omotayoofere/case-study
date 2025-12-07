resource "aws_key_pair" "access-key" {
  key_name   = var.ec2_access_key
  public_key = file(var.ec2_access_key_filepath)  # Replace with the path to your public key
}