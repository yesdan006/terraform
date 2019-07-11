provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_accesskey}"
  secret_key = "${var.aws_secretkey}"
}

resource "aws_instance" "terraformmachine" {

  ami             = "ami-024a64a6685d05041"
  instance_type   = "t2.micro"
  key_name        = "ansible_dynamic"
  security_groups = ["${aws_security_group.ALLTRAFFIC.name}"]


  tags = {
    name = "terraformmachine"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("./ansible_dynamic.pem")}"
    host        = "${aws_instance.terraformmachine.public_ip}"
  }
  provisioner "remote-exec" {
    inline = ["sudo apt-get update -y",
      "sudo apt-get install nginx -y",
    "sudo chmod 777 /var/www/html"]
  }
  provisioner "file" {
    source      = "./mani.html"
    destination = "/var/www/html/mani.html"
  }
}

resource "aws_instance" "terraformmachine2" {

  ami             = "ami-024a64a6685d05041"
  instance_type   = "t2.micro"
  key_name        = "ansible_dynamic"
  security_groups = ["${aws_security_group.ALLTRAFFIC.name}"]

  tags = {
    name = "terraformmachine2"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("./ansible_dynamic.pem")}"
    host        = "${aws_instance.terraformmachine2.public_ip}"
  }
  provisioner "remote-exec" {
    inline = ["sudo apt-get update -y",
      "sudo apt-get install nginx -y",
    "sudo chmod 777 /var/www/html"]
  }
  provisioner "file" {
    source      = "./mani.html"
    destination = "/var/www/html/mani.html"
  }
}
resource "aws_security_group" "ALLTRAFFIC" {
  name = "ALLTRAFFIC"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

