variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "SpringBootCICD"

}

variable "jenkins_ami" {
  default = "ami-0b6c6ebed2801a5cb"
}

variable "sonarqube_ami" {
  default = "ami-0b6c6ebed2801a5cb"
}


variable "instance_type" {
  default = "t3.medium"
}

variable "user" {
  default = "ubuntu"
}

variable "key_pair_name" {
  default = "main-key"
}


variable "public_key" {
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILiC6cwZQyiAl46HJANAUh9k1so1H6LVPkCygAoKvjsL MSI@lyna"
}
