k8s-vpc-cidr="192.168.0.0/16"
subnet_cidr=24

access-key-name="ec2.key"
ec2_access_key_filepath="~/.ssh/id_ed25519.pub"
vpc_name="emart-vpc"
cluster_name="emart-cluster"
public_subnet_count=3
private_subnet_count=3

node_group_name="worker-group-1"
desired_size=3
max_size=4
min_size=2
instance_types=["t3.medium"]

default_ami_type="AL2023_x86_64_STANDARD"
default_capacity_type="ON_DEMAND"
nat_gateway=true
