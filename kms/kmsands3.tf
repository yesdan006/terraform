provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_accesskey}"
  secret_key = "${var.aws_secretkey}"
}

// kms key creation
resource "aws_kms_key" "examplekms" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
}


resource "aws_s3_bucket" "s3example" {
  bucket = "my5a3bucket4"
}



resource "aws_s3_bucket_object" "s3exampleobject" {
  key        = "testfile.html"
  bucket     = "${aws_s3_bucket.s3example.id}"
  source     = "./mani.html"
  kms_key_id = "${aws_kms_key.examplekms.arn}"
}