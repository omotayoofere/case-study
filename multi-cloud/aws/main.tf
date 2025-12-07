module "custom-vpc" {
  source = "./modules/vpc"
  k8s-vpc-cidr = var.k8s-vpc-cidr
  region_name = var.region_name
  subnet_cidr = var.subnet_cidr
  common_tags = local.common_tags
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  vpc_name = var.vpc_name
  nat_gateway = var.nat_gateway

  public_subnet_tags = {
  "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

module "secGroup" {
  depends_on = [ module.custom-vpc ]

  source = "./modules/secGroup"
  tags = merge(
    local.common_tags
  )
  vpc-id = module.custom-vpc.vpc_id
  cluster_name = var.cluster_name
}

module "access-key" {
  source = "./modules/access-key"
  ec2_access_key = var.access-key-name
  ec2_access_key_filepath = var.ec2_access_key_filepath
}

module "eks" {
  source = "./modules/eks"

  public_subnet_ids = module.custom-vpc.public_subnet_ids
  private_subnet_ids = module.custom-vpc.private_subnet_ids
  cluster_name = local.cluster_name
  cluster_version = local.cluster_version
  eks_cluster_sg_id = module.secGroup.eks_cluster_sg_id
  access-key-name = var.access-key-name
  default_ami_type = var.default_ami_type
  default_capacity_type = var.default_capacity_type
  eks_node_groups_sg_id = module.secGroup.eks_node_sg_id
  node_group_name = var.node_group_name
  desired_size = var.desired_size
  max_size = var.max_size
  min_size = var.min_size
  instance_types = var.instance_types
}

# module "k8s-nodes" {
#   source = "./modules/ec2"
#   count = length(module.custom-vpc.subnet_ids)
#   associate-public-ip = var.associate-public-ip[count.index]

#   tags = merge(
#     var.common_tags,
#     {}
#   )

#   subnet-id = module.custom-vpc.subnet_ids[count.index]
#   access-key-name = module.access-key.access-key-name
#   sg-id = flatten([for k, m in module.secGroup : m.secGroup_ids])[count.index]
# }