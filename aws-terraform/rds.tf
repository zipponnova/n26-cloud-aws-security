resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db_credentials"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = "{\"username\":\"dbadmin\", \"password\":\"YOUR_DB_PASSWORD\"}"
}

resource "aws_db_instance" "app_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydatabase"
  username             = "dbadmin"
  password             = jsondecode(aws_secretsmanager_secret_version.db_credentials_version.secret_string)["password"]
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  storage_encrypted = true
  kms_key_id        = aws_kms_key.db_encryption_key.arn

  backup_retention_period = 7
  backup_window           = "04:00-06:00"
  maintenance_window      = "Mon:00:00-Mon:03:00"

  skip_final_snapshot = true  # Set to false in production for data safety

  tags = {
    Name = "app_db_instance"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.db_subnet.id]

  tags = {
    Name = "my-db-subnet-group"
  }
}

resource "aws_kms_key" "db_encryption_key" {
  description = "KMS key for encrypting RDS instance"
}
