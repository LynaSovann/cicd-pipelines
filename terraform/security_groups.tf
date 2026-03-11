#################################
# Jenkins Security Group
#################################

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-server-sg"
  description = "Security group for Jenkins"

  tags = {
    Name    = "jenkins-server-sg"
    Project = var.project_name
  }
}

# SSH access from your IP
resource "aws_vpc_security_group_ingress_rule" "jenkins_ssh" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "175.100.53.222/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Jenkins Web UI
resource "aws_vpc_security_group_ingress_rule" "jenkins_http" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "175.100.53.222/32"
  from_port         = 8080
  to_port           = 8080
  ip_protocol       = "tcp"
}

# Allow Jenkins outbound traffic
resource "aws_vpc_security_group_egress_rule" "jenkins_outbound" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

#################################
# SonarQube Security Group
#################################

resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-server-sg"
  description = "Security group for SonarQube"

  tags = {
    Name    = "sonarqube-server-sg"
    Project = var.project_name
  }
}

# SSH access from your IP
resource "aws_vpc_security_group_ingress_rule" "sonarqube_ssh" {
  security_group_id = aws_security_group.sonarqube_sg.id
  cidr_ipv4         = "175.100.53.222/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Web access to SonarQube from your IP
resource "aws_vpc_security_group_ingress_rule" "sonarqube_web_from_my_ip" {
  security_group_id = aws_security_group.sonarqube_sg.id
  cidr_ipv4         = "175.100.53.222/32"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Allow Jenkins to access SonarQube
resource "aws_vpc_security_group_ingress_rule" "sonarqube_from_jenkins" {
  security_group_id            = aws_security_group.sonarqube_sg.id
  referenced_security_group_id = aws_security_group.jenkins_sg.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

# SonarQube outbound traffic
resource "aws_vpc_security_group_egress_rule" "sonarqube_outbound" {
  security_group_id = aws_security_group.sonarqube_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
