#http://www.admintome.com/blog/provisioning-infrastructure-with-terraform/
provider "aws"
{
access_key= ""
secret_key= "",
region ="us-east-2" 
}
resource "aws_key_pair" "terraform_ec2_key1" {
  key_name = "terraform_ec2_key1"
  public_key="paste ssh-key gen key path is /root/.ssh/id_ras.pub"
}
    resource "aws_instance" "terraformmachine"
{

    ami="ami-7d132e18",
    instance_type="t2.micro",
    key_name="${aws_key_pair.terraform_ec2_key1.key_name}"
tags
{
Name="terraform"
}
connection 
{
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
}
 provisioner "remote-exec"
    {
        inline=[ "sudo apt-get update -y",
                 "sudo apt-get install nginx -y"]
}
}

