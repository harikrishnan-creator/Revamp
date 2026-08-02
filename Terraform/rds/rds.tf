module "db" {
  source  = "terraform-aws-modules/rds/aws"
  engine  = "postgres"
  engine_version = "15.3"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  name     = var.db_name
  username = var.db_user
  password = var.db_password

  vpc_security_group_ids = [var.db_sg_id]
  subnet_ids             = var.private_subnets
  skip_final_snapshot    = true
}
