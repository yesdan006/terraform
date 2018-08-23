#http://www.admintome.com/blog/provisioning-infrastructure-with-terraform/
provider "aws"
{
access_key= ""
secret_key= "",
region ="us-east-2" 
}

variable "count" {
default=2
}
resource "aws_key_pair" "terraform_ec2_key1" {
  key_name = "terraform_ec2_key1"
  public_key="ssh-keygen /root/.ssh/id_rsa.pub"
}
    resource "aws_instance" "terraformmachine"
{

    ami="ami-7d132e18"
    count="${var.count}"
    instance_type="t2.micro"
    key_name="${aws_key_pair.terraform_ec2_key1.key_name}"

tags {
Name="${format("test-%01d",count.index+1)}"
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


