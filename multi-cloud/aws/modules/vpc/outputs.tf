output "vpc_id" {
    value = aws_vpc.k8s-vpc.id
}

output "private_subnet_ids" {
    value = aws_subnet.private_subnets.*.id
}

output "private_subnet_cidrs" {
  value = [for s in aws_subnet.private_subnets : s.cidr_block]
}

output "public_subnet_ids" {
    value = aws_subnet.public_subnets.*.id
}

output "public_subnet_cidrs" {
  value = [for s in aws_subnet.public_subnets : s.cidr_block]
}