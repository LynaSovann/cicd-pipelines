output "jenkins_public_ip" {
  description = "Public IP address of Jenkins server"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_private_ip" {
  description = "Private IP address of Jenkins server"
  value       = aws_instance.jenkins.private_ip
}

output "sonarqube_public_ip" {
  description = "Public IP address of SonarQube server"
  value       = aws_instance.sonarqube.public_ip
}

output "sonarqube_private_ip" {
  description = "Private IP address of SonarQube server"
  value       = aws_instance.sonarqube.private_ip
}

output "jenkins_url" {
  description = "Jenkins Web UI"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}

output "sonarqube_url" {
  description = "SonarQube Web UI"
  value       = "http://${aws_instance.sonarqube.public_ip}"
}

output "ssh_jenkins" {
  value = "ssh -i main-key ubuntu@${aws_instance.jenkins.public_ip}"
}

output "ssh_sonarqube" {
  value = "ssh -i main-key ubuntu@${aws_instance.sonarqube.public_ip}"
}
