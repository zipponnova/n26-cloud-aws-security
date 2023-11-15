output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.app_instance.*.public_ip
}

# Add other outputs as needed for your configuration
