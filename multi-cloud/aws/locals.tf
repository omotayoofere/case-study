locals {
    cluster_name = "emart-cluster"
    cluster_version = "1.34"

    common_tags = merge(
        var.common_tags,
        { Environment = terraform.workspace }
    )
}
