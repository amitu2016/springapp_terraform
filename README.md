# SpringApp Terraform Infrastructure

This project deploys a highly available, scalable infrastructure on AWS for the Spring PetClinic application using Terraform.

## Architecture

The infrastructure consists of the following modules:

-   **VPC**: Creates a production-ready VPC with public, private, and secure subnets across two Availability Zones.
-   **NAT Gateway**: Provisions NAT Gateways for outbound internet access from private subnets.
-   **Security Groups**: Manages network security rules for ALB, EC2, and RDS.
-   **ALB (Application Load Balancer)**: Distributes incoming traffic to the application servers.
-   **EC2**: Configures IAM Roles and Instance Profiles for SSM access.
-   **RDS**: Provisions a MySQL database in secure subnets.
-   **ASG (Auto Scaling Group)**: Manages a fleet of EC2 instances running the application container.
    -   *Crucial Feature*: Uses **AWS Systems Manager (SSM)** to bootstrap instances post-launch, ensuring reliable application startup and database connectivity.

## Prerequisites

-   [Terraform](https://www.terraform.io/downloads.html) >= 1.0
-   [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials.

## Usage

1.  **Initialize Terraform**:
    ```bash
    cd main
    terraform init
    ```

2.  **Plan the Deployment**:
    ```bash
    terraform plan
    ```

3.  **Apply Changes**:
    ```bash
    terraform apply
    ```

## Application Deployment Flow

1.  **Infrastructure Provisioning**: Terraform creates the VPC, Database, Load Balancer, and Auto Scaling Group.
2.  **Instance Launch**: The ASG launches EC2 instances using a clean Amazon Linux 2 AMI.
3.  **Bootstrap (SSM)**: Once an instance is online, an **SSM Association** automatically executes the `userdata.sh` script.
    -   Installs Docker.
    -   Pulls the PetClinic image.
    -   Starts the container with the correct RDS connection strings (injected dynamically).
4.  **Verification**:
    -   Check the **Systems Manager > State Manager** console to see the bootstrap status.
    -   Access the application via the Application Load Balancer DNS name.

## Directory Structure

```
.
├── main/                  # Main Terraform configuration and state
│   ├── main.tf            # Root module composition
│   ├── variables.tf       # Global variables
│   └── outputs.tf         # Root outputs
├── modules/               # Reusable infrastructure modules
│   ├── vpc/
│   ├── asg/               # Includes SSM bootstrap logic
│   ├── rds/
│   ├── alb/
│   ├── ec2/
│   ├── natgateway/
│   └── security_group/
└── README.md
```