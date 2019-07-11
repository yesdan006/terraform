provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_accesskey}"
  secret_key = "${var.aws_secretkey}"
}
resource "aws_kms_key" "examplekms" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
}
resource "aws_efs_file_system" "efs" {
  creation_token = "myfilesystem"
  kms_key_id        = "${aws_kms_key.examplekms.arn}"

}

resource "aws_efs_mount_target" "mounting" {
  file_system_id = "${aws_efs_file_system.efs.id}"
  subnet_id      = "subnet-0a25656d"    
}

