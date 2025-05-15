#!/bin/bash

# CONFIG
ZONE="us-central1-a"
DISK_NAME="anythingllm-disk"
VM_NAME="anythingllm-vm"
REGION="us-central1"
STARTUP_FILE="startup-anythingllm-from-scratch.sh"

# Create the Spot VM with persistent disk and startup script
gcloud compute instances create "$VM_NAME" \
  --zone="$ZONE" \
  --machine-type=e2-standard-4 \
  --preemptible \
  --image-family=ubuntu-2204-lts \
  --image-project=ubuntu-os-cloud \
  --boot-disk-size=10GB \
  --disk="name=$DISK_NAME,device-name=$DISK_NAME,mode=rw,boot=no,auto-delete=no" \
  --tags=http-server \
  --metadata-from-file="startup-script=$STARTUP_FILE" \
  --scopes="https://www.googleapis.com/auth/cloud-platform"
