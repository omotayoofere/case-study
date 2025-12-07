resource "aws_vpc_ipam" "k8s-cluster-ipam" {
  description = "IPAM for VPCs in my current region"
  operating_regions {
      region_name = var.region_name
  }

  tags = merge(
      var.common_tags,
      { Name = "${var.vpc_name}-ipam" }
  )
}

resource "aws_vpc_ipam_scope" "k8s-cluster-ipam-scope" {
  ipam_id     = aws_vpc_ipam.k8s-cluster-ipam.id
  description = "IPAM SCOPE for VPCs in my current region"

  tags = merge(
      var.common_tags,
      { Name = "${var.vpc_name}-ipam-scope" }
  )
}

resource "aws_vpc_ipam_pool" "k8s-cluster-ipam-pool" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam_scope.k8s-cluster-ipam-scope.id
  locale         = var.region_name

  tags = merge(
      var.common_tags,
      { Name = "${var.vpc_name}-ipam-pool" }
  )
}

resource "aws_vpc_ipam_pool_cidr" "k8s-cluster-ipam-pool-cidr" {
    ipam_pool_id = aws_vpc_ipam_pool.k8s-cluster-ipam-pool.id
    cidr         = var.k8s-vpc-cidr
}

#VPC
#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
resource "aws_vpc" "k8s-vpc" {
    cidr_block       = var.k8s-vpc-cidr
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    instance_tenancy = "default"

    tags = merge(
        var.common_tags,
        { Name = var.vpc_name }
    )
}

#SUBNETs ()
#tfsec:ignore:aws-ec2-no-public-ip-subnet
resource "aws_subnet" "private_subnets" {
  count = var.private_subnet_count #var.private_subnet_count
  vpc_id = aws_vpc.k8s-vpc.id
  cidr_block = cidrsubnet(aws_vpc.k8s-vpc.cidr_block, 8, count.index)#var.subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = false #count.index % 2 == 1 ? true : false

  tags = merge(
      var.common_tags, var.private_subnet_tags,
      { Name = "${var.vpc_name}-private-subnet-${count.index + 1}" }
  )
}

resource "aws_subnet" "public_subnets" {
  count = var.public_subnet_count #var.public_subnet_count
  vpc_id = aws_vpc.k8s-vpc.id
  cidr_block = cidrsubnet(aws_vpc.k8s-vpc.cidr_block, 8, count.index + var.public_subnet_count)#var.subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true #count.index % 2 == 1 ? true : false

  tags = merge(
      var.common_tags, var.public_subnet_tags,
      { Name = "${var.vpc_name}-public-subnet-${count.index + 1}" }
  )
}

#INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.k8s-vpc.id

  tags = merge(
    var.common_tags,
    { Name = "${var.vpc_name}-internetgateway" }
  )
}

#NAT GATEWAY
resource "aws_eip" "nat_public_ip" {
  count = var.nat_gateway ? 1 : 0

  domain   = "vpc"
}

resource "aws_nat_gateway" "nat_gateway_resource" {
  count = var.nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat_public_ip[0].id
  subnet_id = aws_subnet.public_subnets[0].id

  tags = merge(
    var.common_tags,
    { Name = "${var.vpc_name}-nat-gateway-default" }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

#PUBLIC ROUTE TABLE
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.k8s-vpc.id

  tags = merge(
    var.common_tags,
    { Name = "${var.vpc_name}-routetable-public" }
  )
}

## Public Route Table rules
resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

#ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "public-rta" {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id    
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.k8s-vpc.id

  tags = merge(
    var.common_tags,
    { Name = "${var.vpc_name}-routetable-private" }
  )
}

## Public Route Table rules
resource "aws_route" "private" {
  route_table_id = aws_route_table.private.id
  nat_gateway_id = var.nat_gateway ? aws_nat_gateway.nat_gateway_resource[0].id : null
  destination_cidr_block = "0.0.0.0/0"
}

#ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "private-rta" {
  count = length(aws_subnet.private_subnets)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}