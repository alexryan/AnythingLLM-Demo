#!/bin/bash

# CONFIG
ZONE="us-central1-a"
REGION="us-central1"
VM_NAME="anythingllm-vm"
DISK_NAME="anythingllm-disk"

echo "⚠️  WARNING: This will permanently delete:"
echo " - VM: $VM_NAME"
echo " - Disk: $DISK_NAME (all saved data)"
read -p "Are you sure you want to continue? [y/N]: " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "🛑 Canceled. No changes made."
  exit 0
fi

echo "🧨 Deleting VM (if exists)..."
gcloud compute instances delete $VM_NAME \
  --zone=$ZONE \
  --quiet \
  || echo "(No VM to delete)"

echo "💽 Deleting persistent disk..."
gcloud compute disks delete $DISK_NAME \
  --zone=$ZONE \
  --quiet \
  || echo "(No disk to delete)"

echo "✅ Teardown complete."
