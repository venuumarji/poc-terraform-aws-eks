resource "aws_security_group" "node_group_sg" {
  name        = "${var.cluster_name}-node-sg"
  description = "Security group for EKS managed node group"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-node-sg"
  })
}


resource "aws_launch_template" "node_lt" {
  name          = "${var.cluster_name}-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  #key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.node_group_sg.id]
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.disk_size
      volume_type = "gp3"
    }
  }

  user_data = base64encode(<<-EOT
    #!/bin/bash
    /etc/eks/bootstrap.sh ${var.cluster_name}

    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<h1>Hello!! Welcome to demo from Terraform!</h1>" > /var/www/html/index.html
  EOT
  )


  tag_specifications {
    resource_type = "instance"
    tags          = merge(var.tags, {
      Name = "${var.cluster_name}-node"
    })
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-managed-ng"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids      = var.subnet_ids

  launch_template {
    name      = aws_launch_template.node_lt.name
    version   = aws_launch_template.node_lt.latest_version
  }

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  tags = var.tags

  depends_on = [
    aws_eks_cluster.this,
    aws_launch_template.node_lt,
    aws_iam_role_policy_attachment.worker_node_policies
  ]
}
