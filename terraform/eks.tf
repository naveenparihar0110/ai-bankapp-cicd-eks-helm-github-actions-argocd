module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "bankapp-eks-tf"
  cluster_version = "1.28"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  eks_managed_node_groups = {
    default = {
      desired_size   = 1
      min_size       = 0
      max_size       = 2
      instance_types = ["m7i-flex.large"]
      ami_type = "AL2023_x86_64_STANDARD"
 	}
 }
access_entries = {
    admin = {
      principal_arn = "arn:aws:iam::407490668259:root"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}

