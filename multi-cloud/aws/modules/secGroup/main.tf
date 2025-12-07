resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = var.vpc-id
  name = "${var.cluster_name}-eks-cluster-sg"
  description = "Security group for EKS cluster control plane communication with worker nodes"
  tags = {
    Name = "${var.cluster_name}-eks-cluster-sg"
  }
}

resource "aws_security_group_rule" "control_plane_ingress_nodes" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.eks_nodes_sg.id
  description              = "Allow inbound traffic from the worker nodes on the Kubernetes API endpoint port"
}

resource "aws_security_group_rule" "control_plane_egress_kubelet" {
  type                     = "egress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.eks_nodes_sg.id
  description              = "Allow control plane traffic to the worker nodes kubelet"
}


resource "aws_security_group" "eks_nodes_sg" {
  vpc_id = var.vpc-id
  name = "${var.cluster_name}-eks-nodes-sg"
  description = "Security group for all nodes in the cluster"
  tags = {
    Name = "${var.cluster_name}-eks-nodes-sg"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

resource "aws_security_group_rule" "worker_node_ingress_kubelet" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_nodes_sg.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
  description              = "Allow inbound traffic from the control plane for kubelet interaction"
}

resource "aws_security_group_rule" "worker_node_to_worker_node_ingress" {
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  self                     = true
  security_group_id        = aws_security_group.eks_nodes_sg.id
  description              = "Allow worker nodes to communicate with one another"
}

resource "aws_security_group_rule" "worker_node_egress" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = [ "0.0.0.0/0" ]
  security_group_id        = aws_security_group.eks_nodes_sg.id
  description              = "Allow outbound internet access"
}

resource "aws_security_group_rule" "worker_to_worker_COREDNS_ingress_tcp" {
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "tcp"
  self                     = true 
  security_group_id        = aws_security_group.eks_nodes_sg.id
  description              = "Allows workers nodes to communicate with each other on COREDNS port (TCP)"
}

resource "aws_security_group_rule" "worker_to_worker_COREDNS_ingress_udp" {
  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "udp"
  self                     = true 
  security_group_id        = aws_security_group.eks_nodes_sg.id
  description              = "Allows workers nodes to communicate with each other on COREDNS port (UDP)"
}
