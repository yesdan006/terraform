provider "aws" {
    region ="us-east-1"  
  
}

terraform {
backend "s3" {
 encrypt = true
 bucket = "backend5a2"
 dynamodb_table = "terraform_state_lock"
 region = "us-east-1"
 key = "terraform.tfstate"
 }
}



module "ec2" {
  source         = "./ec2"
  //privatekeypath = "./ansible_dynamic.pem"
//  accesskey      = "${var.aws_accesskey}"
 // secretkey      = "${var.aws_secretkey}"
  
}