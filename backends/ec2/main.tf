provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_accesskey}"
  secret_key = "${var.aws_secretkey}"
}

resource "aws_instance" "terraformmachine1" {

  ami             = "ami-026c8acd92718196b"
  instance_type   = "t2.micro"
  key_name        = "ansible_dynamic"
  
}
