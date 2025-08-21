variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name for the EKS cluster and associated resources."
  type        = string
  default     = "Nginx-EKS-Cluster"
}