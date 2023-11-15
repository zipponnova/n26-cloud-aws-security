
# Deploying Falcon Sensor on EC2 Instances using Ansible

This guide provides an example of how to deploy CrowdStrike Falcon Sensor on AWS EC2 instances using Ansible.

## Prerequisites
- Ansible installed on your control machine.
- AWS EC2 instances up and running.
- SSH access to the EC2 instances.
- Falcon Sensor installation files available.

## Steps

1. **Clone the Ansible Playbook Repository**
   ```bash
   git clone https://github.com/StuartApp/ansible-falcon.git
   cd ansible-falcon
   ```

2. **Configure Ansible Inventory**
   Edit the `hosts` file to add your EC2 instances. For example:
   ```ini
   [ec2_instances]
   ec2-instance-1 ansible_host=ec2-instance-1-ip
   ec2-instance-2 ansible_host=ec2-instance-2-ip
   ```

3. **Set Up SSH Keys**
   Ensure your control machine has SSH access to the EC2 instances.

4. **Configure Playbook Variables**
   Edit `vars/main.yml` to set the Falcon Sensor download URL and any other necessary variables.

5. **Run the Ansible Playbook**
   Execute the playbook to install Falcon Sensor on the EC2 instances.
   ```bash
   ansible-playbook -i hosts main.yml
   ```

## Secret Management
For added security, consider using AWS Secrets Manager to manage the Falcon Sensor installation keys and any other sensitive data.

## Note
- Ensure that the Falcon Sensor download URL and installation keys are updated and valid.
- Test the playbook in a staging environment before deploying it in production.

