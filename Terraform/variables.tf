variable "region" { default = "ap-south-1" }
variable "cluster_name" { default = "myapp-cluster" }
variable "vpc_id" {}
variable "private_subnets" { type = list(string) }
variable "db_name" { default = "mydb" }
variable "db_user" { default = "postgres" }
variable "db_password" {}
variable "db_sg_id" {}
variable "app_image" {}
