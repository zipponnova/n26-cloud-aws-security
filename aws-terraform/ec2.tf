resource "aws_instance" "app_instance" {
  count                         = 3  # Number of instances to create
  ami                           = "ami-12345678"  # Replace with the correct AMI ID
  instance_type                 = "t2.micro"  # Or another instance type as per your requirements
  key_name                      = "your-key-pair-name"  # SSH key pair name
  vpc_security_group_ids        = [aws_security_group.app_sg.id]
  subnet_id                     = aws_subnet.app_subnet.id  # Place instance in the application subnet
  associate_public_ip_address   = true  # Set to false if instances should not be publicly accessible

  tags = {
    Name = "AppInstance-${count.index}"
  }

  # Add additional configurations as needed
}
