#!/bin/bash

# Fetch secrets from environment variables
codedeploy_application_name="${CODEDEPLOY_APPLICATION}"
codedeploy_groupname="${CODEDEPLOY_GROUPNAME}"
aws_s3_bucket_name="${AWS_S3_BUCKET}"

# Check if required variables are set
if [ -z "$codedeploy_application_name" ] || [ -z "$codedeploy_groupname" ] || [ -z "$aws_s3_bucket_name" ]; then
  echo "Error: Required environment variables are not set."
  exit 1
fi

# Create a deployment
deployment_id=$(aws deploy create-deployment \
    --application-name "$codedeploy_application_name" \
    --deployment-group-name "$codedeploy_groupname" \
    --s3-location bucket="$aws_s3_bucket_name",bundleType=zip,key=cicd-codedeploy/${GITHUB_RUN_ID}.zip \
    --output text --query 'deploymentId')

# Check if the deployment ID was retrieved successfully
if [ -z "$deployment_id" ]; then
  echo "Error: Failed to create deployment."
  exit 1
fi

echo "Deployment created with ID: $deployment_id"
echo $deployment_id > deployment_id.txt

# Wait for the deployment to complete
aws deploy wait deployment-successful --deployment-id "$deployment_id"
