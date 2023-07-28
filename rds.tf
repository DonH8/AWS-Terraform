data "aws_subnet" "public_subnet_1" {
  id = "	subnet-0f5325201f2306f9a"  
}

data "aws_subnet" "private_subnet_1" {
  id = "subnet-02b98ef0bf5e1c2b8" 
}
data "aws_subnet" "public_subnet_2" {
  id = "subnet-008aadb71d0077635"  
}

data "aws_subnet" "private_subnet_2" {
  id = "subnet-0617ee8091cf0f072" 
}
data "aws_subnet" "public_subnet_3" {
  id = "subnet-040ebaea2878fae58"  
}

data "aws_subnet" "private_subnet_3" {
  id = "subnet-0c0d421275fc8fadb"  
}

resource "aws_rds_cluster" "don_rds_cluster" {
  cluster_identifier   = "don-cluster"
  engine               = "mysql"  
  engine_version       = "8.0.28"
  database_name        = "don_db"
  master_username      = "admin"
  master_password      = "password"
  db_cluster_instance_class = "db.m5d.large"
  storage_type            = "io1"
  iops                    = 1000
  allocated_storage = 100
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  backup_retention_period = 7
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
    data.aws_subnet.public_subnet_2.id,
    data.aws_subnet.private_subnet_2.id,
    data.aws_subnet.public_subnet_3.id,
    data.aws_subnet.private_subnet_3.id
  ]
}
