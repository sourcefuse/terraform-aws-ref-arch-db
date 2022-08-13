################################################
## imports
################################################
## vpc
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["refarchdevops-${var.environment}-vpc"]
  }
}

## network
data "aws_subnets" "private" {
  filter {
    name = "tag:Name"
    values = [
      "refarchdevops-${var.environment}-privatesubnet-private-${var.region}a",
      "refarchdevops-${var.environment}-privatesubnet-private-${var.region}b"
    ]
  }
}

## security
data "aws_security_groups" "db_sg" {
  filter {
    name   = "group-name"
    values = ["refarchdevops-${var.environment}-db-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

data "aws_security_groups" "eks_sg" {
  filter {
    name   = "group-name"
    values = ["refarchdevops-${var.environment}-eks-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}
