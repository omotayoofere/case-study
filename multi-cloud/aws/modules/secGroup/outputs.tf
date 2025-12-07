output "eks_cluster_sg_id" {
  value = aws_security_group.eks_cluster_sg.id
}

output "eks_node_sg_id" {
  value = aws_security_group.eks_nodes_sg.id
}

# output "sg_ids" {
#   value = [for sg in aws_security_group.security_group_template : sg.id]
# }
