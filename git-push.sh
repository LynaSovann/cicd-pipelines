#!/bin/bash

# Stage all changes
git add .

# Commit with the provided message
git commit -m "Updated by Lyna"

# Push to the current branch
git push origin main

echo "✅ Code pushed successfully!"