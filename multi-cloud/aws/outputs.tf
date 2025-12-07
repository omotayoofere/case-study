# output "subnet_ids" {
#   value = module.custom-vpc.subnet_ids
# }

output "vpc_id" {
  value = module.custom-vpc.vpc_id
}

# output "subnet_cidrs" {
#   value = module.custom-vpc.subnet_cidrs
# }

# output "all_sg_ids" {
#   value = flatten([for k, m in module.secGroup : m.secGroup_ids])
# }

# output "public-ips" {
#   value = [for m in module.k8s-nodes : m.ec2-ips]
# }