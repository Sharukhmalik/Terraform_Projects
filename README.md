# 🏰 Bastion Host — Terraform Infrastructure

A production-ready Terraform module for deploying a secure bastion host on AWS. This project provisions an EC2 instance with an associated security group inside an existing VPC, following AWS and Terraform best practices.

---

## 📁 Project Structure

```
bo_bastion/
├── Configuration/
│   └── dev.tfvars              # Environment-specific variable values
│
├── main/                       # Root module — run Terraform from here
│   ├── provider.tf             # AWS provider and backend configuration
│   ├── variable.tf             # Input variable declarations
│   ├── local.tf                # Local values (common tags)
│   ├── data.tf                 # Data sources (VPC, subnets)
│   ├── main.tf                 # Module calls (ec2 + sg)
│   └── output.tf               # Output values
│
└── modules/
    ├── ec2/                    # EC2 child module
    │   ├── data.tf             # AMI lookup
    │   ├── main.tf             # EC2 instance resource
    │   ├── output.tf           # Instance outputs
    │   └── variable.tf         # EC2 module variables
    │
    └── sg/                     # Security Group child module
        ├── main.tf             # Security group resources
        ├── output.tf           # SG outputs
        ├── variable.tf         # SG module variables
        └── versions.tf         # Provider version constraints
```

---

## ✅ Prerequisites

Before you begin, ensure you have the following installed and configured:

| Tool | Version | Install |
|---|---|---|
| Terraform | >= 1.0.0 | [terraform.io](https://developer.hashicorp.com/terraform/install) |
| AWS CLI | >= 2.0.0 | [aws.amazon.com/cli](https://aws.amazon.com/cli/) |
| AWS Account | — | With IAM permissions for EC2, VPC, IAM |

### AWS Permissions Required

Your IAM user/role needs at minimum:
- `AmazonEC2FullAccess`
- `AmazonVPCReadOnlyAccess`
- `IAMReadOnlyAccess`

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/bo_bastion.git
cd bo_bastion
```

### 2. Configure AWS Credentials

```bash
aws configure
# Enter your Access Key ID, Secret Access Key, and region (ap-south-1)
```

Verify credentials are working:
```bash
aws sts get-caller-identity
```

### 3. Update Variables

Edit `Configuration/dev.tfvars` with your real AWS values:

```hcl
# Tags
tag_CostCentre    = "BusinessUnit-Platform"
tag_ApplicationId = "AL032"
tag_SupportGroup  = "AL032-Support"
tag_Owner         = "your-team@yourcompany.com"
tag_AppCategory   = "B"
tag_Environment   = "dev"

# Network — replace with real values
vpc_id            = "vpc-0xxxxxxxxxxxxxxxxx"
bastion_subnet_id = "subnet-0xxxxxxxxxxxxxxxxx"

# EC2
bastion_instance_name    = "bastion-dev"
bastion_instance_type    = "t3.micro"
ec2_key_name             = "your-key-pair-name"
ec2_iam_instance_profile = "your-iam-instance-profile"
aws_root_account_id      = "xxxxxxxxxxxx"
```

### 4. Verify AWS Resources Exist

Before applying, confirm these resources exist in your AWS account:

```bash
# Check VPC
aws ec2 describe-vpcs --region ap-south-1 \
  --query "Vpcs[*].{ID:VpcId,Name:Tags[?Key=='Name']|[0].Value}" \
  --output table

# Check subnets
aws ec2 describe-subnets --region ap-south-1 \
  --query "Subnets[*].{ID:SubnetId,AZ:AvailabilityZone,VPC:VpcId}" \
  --output table

# Check key pairs
aws ec2 describe-key-pairs --region ap-south-1 \
  --query "KeyPairs[*].KeyName" --output table

# Check IAM instance profiles
aws iam list-instance-profiles \
  --query "InstanceProfiles[*].InstanceProfileName" --output table
```

### 5. Initialise Terraform

```bash
cd main
terraform init
```

### 6. Plan

```bash
terraform plan \
  -var "region=ap-south-1" \
  -var-file="../Configuration/dev.tfvars" \
  -lock=false \
  -input=false \
  -out="BO_BASTION_TFPLAN"
```

### 7. Apply

```bash
terraform apply "BO_BASTION_TFPLAN"
```

---

## 🔧 Common Commands

```bash
# Validate configuration
terraform validate

# Format code
terraform fmt -recursive

# View current state
terraform show

# Destroy all resources
terraform destroy \
  -var "region=ap-south-1" \
  -var-file="../Configuration/dev.tfvars" \
  -lock=false
```

---

## 📤 Outputs

After a successful apply, Terraform will output:

| Output | Description |
|---|---|
| `bastion_id` | EC2 instance ID |
| `bastion_security_group_id` | Security group ID |
| `tooling_vpc_id` | VPC ID |
| `tooling_subnet_a_id` | Subnet A ID (ap-south-1a) |
| `tooling_subnet_b_id` | Subnet B ID (ap-south-1b) |
| `tooling_subnet_c_id` | Subnet C ID (ap-south-1c) |

---

## 🔒 Security Considerations

- **IMDSv2** is enforced on the EC2 instance to prevent SSRF attacks
- **Root EBS volume** is encrypted by default
- **Egress rules** default to allow all outbound traffic — restrict as needed
- **SSH access** is controlled via key pair — consider AWS Session Manager as an alternative
- **IAM instance profile** should follow least privilege principle
- Never commit `terraform.tfstate` or `*.tfvars` files containing sensitive values to Git

---

## 📋 Variables Reference

| Variable | Description | Default |
|---|---|---|
| `region` | AWS region | `ap-south-1` |
| `vpc_id` | VPC ID for the bastion host | required |
| `bastion_subnet_id` | Subnet ID for the instance | required |
| `bastion_instance_name` | Name tag for the instance | `bastion-dev` |
| `bastion_instance_type` | EC2 instance type | `t3.micro` |
| `bastion_ami_name` | AMI name pattern | `amzn2-ami-hvm-*-x86_64-gp2` |
| `ec2_key_name` | SSH key pair name | `null` |
| `ec2_iam_instance_profile` | IAM instance profile name | `""` |
| `aws_root_account_id` | AWS account ID | required |
| `tag_CostCentre` | Cost centre tag | `""` |
| `tag_ApplicationId` | Application ID tag | `""` |
| `tag_SupportGroup` | Support group tag | `""` |
| `tag_Owner` | Owner email tag | required |
| `tag_AppCategory` | App category tag | `B` |
| `tag_Environment` | Environment tag | `dev` |

---

## 🗂️ .gitignore

Make sure your `.gitignore` includes:

```gitignore
# Terraform state
*.tfstate
*.tfstate.backup
*.tfstate.lock.info

# Terraform plan files
*.tfplan
BO_BASTION_TFPLAN

# Terraform directories
.terraform/
.terraform.lock.hcl

# Variable files with sensitive values
*.tfvars

# Credentials
*.pem
*.key
```

---

## 👤 Author

**Sharukh Malik**
- GitHub: [@sharukhmalik](https://github.com/sharukhmalik)

---

## 📄 License

This project is licensed under the MIT License.
