provider "aws"
{
access_key= ""
secret_key= "",
region ="us-east-2" 
}
resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key="do ssh-keygen and paste here"
  }
    resource "aws_instance" "terraformmachine"
{

    ami="ami-7d132e18",
    instance_type="t2.micro",
    key_name="${aws_key_pair.terraform_ec2_key.key_name}"
}
