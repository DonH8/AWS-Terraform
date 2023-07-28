data "aws_subnet" "public_subnet_1" {
  id = "subnet-0bb094a1b5362e744"  # Replace this with the ID of your first existing subnet
}

data "aws_subnet" "private_subnet_1" {
  id = "subnet-00cc566fe5d99ab7e"  # Replace this with the ID of your second existing subnet
}

resource "aws_rds_cluster" "don_rds_cluster" {
  cluster_identifier   = "don-cluster"
  engine               = "mysql"  # Change this to your desired database engine
  engine_version       = "8.0.26"
  database_name        = "don_db"
  master_username      = "admin"
  master_password      = "password"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  backup_retention_period = 7
}

resource "aws_rds_cluster_instance" "don_rds_instance" {
  cluster_identifier = aws_rds_cluster.don_rds_cluster.id
  instance_class     = "db.t2.small"  # Change this to your desired instance type
  engine               = "mysql"  # Change this to your desired database engine
  engine_version       = "8.0.26"
}

resource "aws_rds_cluster_parameter_group" "don_cluster_parameter_group" {
  name        = "don-cluster-parameter-group"
  family      = "mysql8.0"
  description = "Custom parameter group for the RDS"
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "don-db-subnet-group"
  subnet_ids = [
    data.aws_subnet.public_subnet_1.id,
    data.aws_subnet.private_subnet_1.id,
  ]
}
