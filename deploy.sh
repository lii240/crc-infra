#!/bin/bash

# Initialize Terraform backend (if not already initialized)
if [ ! -d ".terraform" ]; then
  terraform init
fi

# Plan and apply changes
terraform plan
terraform apply --auto-approve

# Display information about the deployed resources (optional)
terraform show