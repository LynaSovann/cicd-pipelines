resource "aws_instance" "sonarqube" {
  ami                    = var.sonarqube_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.main_key.key_name
  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]
  availability_zone      = "us-east-1a"

  tags = {
    Name    = "sonarqube"
    Project = var.project_name
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > sonarqube_ip.txt"
  }
}
