variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "db_name" {
  description = "The database name"
  type        = string
  default     = "mydatabase"
}

variable "db_password" {
  description = "The database password"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "app_subnet_cidr" {
  description = "The CIDR block for the application subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "db_subnet_cidr" {
  description = "The CIDR block for the database subnet"
  type        = string
  default     = "10.0.2.0/24"
}

# Add additional variables as needed.
