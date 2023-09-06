#!/bin/bash

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