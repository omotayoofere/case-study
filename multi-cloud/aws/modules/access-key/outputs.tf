output "access-key-fingerprint" {
  value = aws_key_pair.access-key.fingerprint
}

output "access-key-name" {
  value = aws_key_pair.access-key.key_name
}

output "access-key-id" {
  value = aws_key_pair.access-key.id
}