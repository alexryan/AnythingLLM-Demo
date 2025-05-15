#!/bin/bash

# Wait for the persistent disk to be attached
for i in {1..30}; do
  [ -b /dev/sdb ] && break
  sleep 1
done

# Mount the persistent disk (no formatting!)
mkdir -p /mnt/anythingllm
mount /dev/sdb /mnt/anythingllm
chown -R sryan:sryan /mnt/anythingllm

# Start AnythingLLM from the existing install
cd /mnt/anythingllm/anything-llm

# Launch in background and log output
nohup npm start > /mnt/anythingllm/anything-llm/server.log 2>&1 &
