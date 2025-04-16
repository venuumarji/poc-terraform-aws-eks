resource "aws_iam_role" "ebs_csi_driver" {
  name = "${var.cluster_name}-ebs-csi-driver"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ebs_csi_policy" {
  role       = aws_iam_role.ebs_csi_driver.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name         = aws_eks_cluster.this.name
  addon_name           = "vpc-cni"
  addon_version        = "v1.19.0-eksbuild.1" 
  #resolve_conflicts    = "OVERWRITE"
  depends_on = [
    aws_eks_cluster.this,
    #aws_eks_node_group.this
  ]
}

/*resource "aws_eks_addon" "coredns" {
  cluster_name         = aws_eks_cluster.this.name
  addon_name           = "coredns"
  addon_version        = "v1.11.4-eksbuild.2"
  #resolve_conflicts    = "OVERWRITE"
  depends_on = [
    aws_eks_cluster.this,
    aws_eks_node_group.this
  ]
}*/

/*resource "aws_eks_addon" "ebs_csi" {
  cluster_name             = aws_eks_cluster.this.name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.40.0-eksbuild.1"
  service_account_role_arn = aws_iam_role.ebs_csi_driver.arn
  #resolve_conflicts        = "OVERWRITE"
  depends_on = [
    aws_eks_cluster.this,
    aws_eks_node_group.this,
    aws_iam_role_policy_attachment.ebs_csi_policy
  ]
}
*/
