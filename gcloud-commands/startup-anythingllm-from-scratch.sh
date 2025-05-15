#!/bin/bash

# Install dependencies
apt-get update
apt-get install -y docker.io curl git nodejs npm unzip file

# Wait for /dev/sdb (persistent disk) to appear
for i in {1..30}; do
  [ -b /dev/sdb ] && break
  sleep 1
done

# Check for existing filesystem, format if missing
if ! file -s /dev/sdb | grep -q ext4; then
  echo "Formatting /dev/sdb as ext4..."
  mkfs.ext4 -F /dev/sdb
fi

# Mount the disk
mkdir -p /mnt/anythingllm
mount /dev/sdb /mnt/anythingllm
chown -R $USER:$USER /mnt/anythingllm

# Go to working dir
cd /mnt/anythingllm

# Install AnythingLLM if missing
if [ ! -d "anything-llm" ]; then
  git clone https://github.com/Mintplex-Labs/anything-llm.git
  cd anything-llm
  npm install
else
  cd anything-llm
fi

# Start the app in the background
npm run dev &

