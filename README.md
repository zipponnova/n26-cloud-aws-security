
# N26 Cloud Security Assignment on AWS

## Introduction

This project demonstrates the setup of a highly available and secure multi-tier application on AWS, using Terraform for Infrastructure as Code (IaC). The application includes an application server tier, a backend database, and incorporates various AWS services for security, performance, and scalability.

## Architecture Overview

The project sets up the following components:

- **EC2 Instances**: Hosted within an Auto Scaling Group for scalability and resilience.
- **RDS Instance**: The backend database, configured with encryption for security.
- **Elastic Load Balancer (ELB)**: To distribute traffic across the EC2 instances.
- **S3 Bucket**: For storing application logs and data.
- **AWS CloudWatch**: For monitoring the infrastructure and setting alarms.
- **IAM Roles and Policies**: For secure and restricted access to AWS services.
- **Security Groups**: To control inbound and outbound traffic for EC2 and RDS.
- **AWS Key Management Service (KMS)**: For managing encryption keys.
- **AWS Secrets Manager**: To securely manage database credentials.

## Prerequisites

- An AWS account with required permissions.
- Terraform installed on your local machine.
- AWS CLI, configured with appropriate credentials.

## Directory Structure

```plaintext
.
├── ec2.tf
├── cloudwatch.tf
├── iam.tf
├── outputs.tf
├── provider.tf
├── rds.tf
├── s3.tf
├── sg.tf
├── vpc.tf
└── variables.tf
```

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone [repository_url]
   ```

2. **Initialize Terraform**:
   Navigate to the cloned repository and run:
   ```bash
   terraform init
   ```

3. **Deploy the Infrastructure**:
   Apply the Terraform configurations:
   ```bash
   terraform apply
   ```
   Confirm the deployment when prompted.

4. **Verify Resources**:
   Check the AWS Management Console to ensure all resources are deployed correctly.

## Testing the Setup

- Access the EC2 instances and RDS database via the AWS Console.
- Validate the load balancing through the ELB DNS endpoint.
- Monitor infrastructure performance and alerts through CloudWatch.

## Cleanup

To tear down the infrastructure and avoid unnecessary charges, run:
```bash
terraform destroy
```

## AWS Infrastructure Diagram
![AWS Infrastructure](https://github.com/zipponnova/n26-cloud-aws-security/blob/main/n26_cloud_security_assignment_architecture.png)


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.
