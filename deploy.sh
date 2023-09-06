#!/bin/bash

# Function to perform state backup
backup_state() {
  terraform state pull > terraform.tfstate.backup
}

# Function to handle backend configuration change
handle_backend_change() {
  # Perform state backup
  backup_state

  # Reinitialize Terraform to apply new backend configuration
  terraform init -reconfigure

  # Push the state to the new backend
  terraform state push terraform.tfstate.backup
}

# Initialize Terraform
terraform init

# Detect changes in backend configuration
if [[ "$(terraform init -reconfigure 2>&1 | grep 'A change in the backend configuration')" ]]; then
  echo "Detected backend configuration change. Handling state migration..."
  handle_backend_change
  echo "Backend configuration change handled successfully."
fi

# Plan and apply changes
terraform plan
terraform apply --auto-approve

# Display information about the deployed resources (optional)
terraform show