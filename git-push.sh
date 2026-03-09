#!/bin/bash

# Stage all changes
git add .

# Commit with the provided message
git commit -m "Updated by Lyna"

# Push to the current branch
git push origin springboot-ecs-cicd-pipeline

echo "✅ Code pushed successfully!"