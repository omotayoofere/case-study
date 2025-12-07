locals {
    common_tags = merge(
        var.common_tags,
        { Environment = terraform.workspace }
    )
}