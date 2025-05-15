gcloud compute firewall-rules create allow-anythingllm \
  --allow tcp:3001 \
  --target-tags=http-server \
  --description="Allow traffic to AnythingLLM UI"
