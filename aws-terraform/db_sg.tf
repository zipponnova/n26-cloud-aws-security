resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Security group for database tier"
  vpc_id      = aws_vpc.app_vpc.id

  # Inbound rules
  ingress {
    from_port   = 3306 # Replace with your DB port
    to_port     = 3306 # Replace with your DB port
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id]
    description = "Allow MySQL traffic from the application tier"
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db_sg"
  }
}
