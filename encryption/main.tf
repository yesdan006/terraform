provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_accesskey}"
  secret_key = "${var.aws_secretkey}"
}
resource "aws_kms_key" "examplekms" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
}
resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 8
  encrypted         = true
  kms_key_id        = "${aws_kms_key.examplekms.arn}"
}

resource "aws_volume_attachment" "ebs_att" {
 device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.example.id}"
  instance_id = "${aws_instance.terraformmachine.id}"
  depends_on  = ["aws_ebs_volume.example"]
}

resource "aws_instance" "terraformmachine" {

  ami             = "ami-024a64a6685d05041"
  instance_type   = "t2.micro"
  key_name        = "ansible_dynamic"
  availability_zone = "us-east-1a"


  tags = {
    Name = "terraforminstance"
  }
 
}

