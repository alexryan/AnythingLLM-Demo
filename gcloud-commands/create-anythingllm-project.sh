#!/bin/bash

# === USER CONFIGURABLE ===
export PROJECT_ID="anythingllm-demo-$RANDOM"       # must be globally unique
export PROJECT_NAME="AnythingLLM Demo"
export BILLING_ACCOUNT_ID="[REPLACE_ME]"           # use `gcloud beta billing accounts list`

export REGION="us-central1"
export ZONE="us-central1-a"
# ==========================

echo "🚧 Creating project: $PROJECT_ID"

# Step 1: Create the project
gcloud projects create "$PROJECT_ID" \
  --name="$PROJECT_NAME" \
  --set-as-default

# Step 2: Link it to billing
echo "💰 Linking to billing account: $BILLING_ACCOUNT_ID"
gcloud beta billing projects link "$PROJECT_ID" \
  --billing-account="$BILLING_ACCOUNT_ID"

# Step 3: Enable required APIs
echo "✅ Enabling APIs..."
gcloud services enable compute.googleapis.com \
                          iam.googleapis.com \
                          billingbudgets.googleapis.com

# Step 4: Set region and zone
echo "📍 Setting region to $REGION and zone to $ZONE"
gcloud config set compute/region "$REGION"
gcloud config set compute/zone "$ZONE"

echo "✅ Project '$PROJECT_ID' setup complete and ready for use."
gcloud config list project
