resource "aws_instance" "jenkins" {
  ami                    = var.jenkins_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.main_key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  availability_zone      = "us-east-1a"

  tags = {
    Name    = "jenkins"
    Project = var.project_name
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > jenkins_ip.txt"
  }
}
