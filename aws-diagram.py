from diagrams import Cluster, Diagram
from diagrams.aws.compute import EC2, EC2AutoScaling
from diagrams.aws.database import RDS
from diagrams.aws.network import ELB, VPC, InternetGateway, NATGateway
from diagrams.aws.storage import S3
from diagrams.aws.management import Cloudwatch
from diagrams.aws.security import IAMRole, KMS, SecretsManager

with Diagram("N26 Cloud Security Assignment Architecture", show=False):
    # Define main components
    vpc = VPC("VPC")
    internet_gateway = InternetGateway("Internet Gateway")
    nat_gateway = NATGateway("NAT Gateway")
    load_balancer = ELB("Load Balancer")
    rds_instance = RDS("RDS DB Instance")
    s3_bucket = S3("S3 Logs Bucket")
    cloudwatch_monitoring = Cloudwatch("CloudWatch Monitoring")
    iam_role = IAMRole("IAM Role")
    kms_service = KMS("KMS for Encryption")
    secrets_manager_service = SecretsManager("Secrets Manager")

    # Define EC2 instances within an autoscaling group
    with Cluster("Autoscaling Group"):
        autoscaling_group = EC2AutoScaling("EC2 Autoscaling")
        ec2_instances = [EC2("EC2 Instance") for _ in range(3)]

    # Diagram connections
    vpc >> internet_gateway >> load_balancer >> autoscaling_group >> ec2_instances
    vpc >> nat_gateway >> rds_instance
    ec2_instances >> cloudwatch_monitoring
    rds_instance >> cloudwatch_monitoring
    ec2_instances >> s3_bucket
    rds_instance >> kms_service
    ec2_instances >> secrets_manager_service

    # IAM role association
    iam_role >> ec2_instances
