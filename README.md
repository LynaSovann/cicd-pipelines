# CI/CD Pipeline Implementations

## Workflow

<div align="center"> <img src="./assets/diagram.png" alt="CI/CD Workflow Diagram" height="200" /> </div>

## AWS Infra

<div align="center"> <img src="./assets/aws-infra.png" alt="AWS Infrastructure Diagram" height="200" /> </div>

### Jenkins Server Setup

- Tools Installed
  - Docker Engine
  - Trivy (Security Scanning)
  - AWS CLI
  - OpenJDK (17 & 21)
- Jenkins Plugins
  - Git
  - Pipeline Maven Integration
  - Docker
  - Docker Pipeline
  - AWS Credentials
  - Amazon Web Services SDK:: all
  - Pipeline: AWS Steps
  - SonarQube Scanner
  - Build Timestamp
  - CloudBees Docker Build and Publish
  - Slack Notification

---

### Result

<div align="center"> <img src="./assets/result.png" alt="Pipeline Result Screenshot" height="200" /> </div>
