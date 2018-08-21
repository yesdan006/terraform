provider "aws"
{
access_key= "${var.accesskey}"
secret_key= "${var.secretkey}",
region ="us-east-2" 
}

    resource "aws_instance" "terraformmachine"
{

    ami="ami-7d132e18",
    instance_type="t2.micro",
    key_name= "terraform"
    security_groups=["${aws_security_group.ALLTRAFFIC.name}"]
    connection 
    {
    user="ubuntu",
    private_key="${file(var.privatekey)}"
    }
    provisioner "remote-exec"
    {
        inline=[ "sudo apt-get update -y",
                 "sudo apt-get install tomcat7 -y"]
}
    }
 resource "aws_security_group" "ALLTRAFFIC"
 {
    name="ALLTRAFFIC"

    ingress{
        from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

egress
{
       from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]

}

 }   
 output "publicip"
 {
value="${aws_instance.terraformmachine.public_ip}"

 }  