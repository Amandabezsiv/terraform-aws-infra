# terraform-aws-infra

AWS infrastructure project using Terraform. This project creates a basic AWS setup including VPC, EC2 instance, and S3 bucket.

## Project Structure

```
.
├── README.md
├── environments/
│   └── dev/
│       ├── main.tf          # Main configuration for the development environment
│       ├── dev.tfvars       # Environment-specific variables
│       └── terraform.tfstate # Terraform state file
└── modules/
    ├── ec2_instance/        # Module for EC2 instances
    ├── s3_bucket/           # Module for S3 buckets
    └── vpc/                 # Module for VPC and networking
```

## Resources Created

- **VPC** with public subnet, Internet Gateway, and route table
- **EC2 Instance** (t2.micro) in the public subnet with public IP
- **S3 Bucket** for storage

## Prerequisites

1. **Terraform** installed (version >= 1.0)
   ```bash
   # On Ubuntu/Debian
   wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
   sudo apt update && sudo apt install terraform
   ```

2. **AWS CLI** configured
   ```bash
   aws configure
   ```

3. **AWS Credentials** configured (via AWS CLI, environment variables, or IAM roles)

## How to Run

### 1. Clone the repository
```bash
git clone <repository-url>
cd terraform-aws-infra
```

### 2. Go to the desired environment
```bash
cd environments/dev
```

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Review the execution plan
```bash
terraform plan -var-file="dev.tfvars"
```

### 5. Apply the infrastructure
```bash
terraform apply -var-file="dev.tfvars"
```

### 6. To destroy the infrastructure
```bash
terraform destroy -var-file="dev.tfvars"
```

## Configuration

Development environment variables are in `environments/dev/dev.tfvars`. You can modify:

- `ami_id`: AMI ID for the EC2 instance
- `instance_type`: EC2 instance type
- `instance_name`: EC2 instance name

## Modules

### VPC (`modules/vpc/`)
- Creates VPC with CIDR 10.0.0.0/16
- Public subnet in sa-east-1a
- Internet Gateway for internet access
- Configured route table

### EC2 Instance (`modules/ec2_instance/`)
- EC2 instance with public IP
- Configurable via variables
- Associated with the VPC public subnet

### S3 Bucket (`modules/s3_bucket/`)
- S3 bucket with force_destroy enabled
- Name configurable via variables

## Notes

- The project is set for the **sa-east-1** region (São Paulo)
- The EC2 instance uses Ubuntu 22.04 LTS AMI
- The S3 bucket has `force_destroy = true` for testing purposes (be careful in production!)

## Next Steps

- Add Security Groups
- Configure automatic backup
- Implement module outputs
- Add more environments (staging, prod)
- Configure remote state
- Implement IAM roles and policies
- Set up Terraform workspace to manage multiple environments
- Create reusable modules for common components (e.g., VPC, EC2, SG)
- Implement CI/CD with GitHub Actions to automate deployment
- Configure monitoring with CloudWatch (logs and metrics)
- Add consistent tagging to all resources
- Automate snapshots and backup routines for EBS volumes
