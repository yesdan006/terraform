provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_accesskey}"
  secret_key = "${var.aws_secretkey}"
}
resource "aws_instance" "terraformmachine" {

    ami="ami-00d4e9ff62bc40e03"
    instance_type="t2.micro"
    key_name="terraform"
    security_groups= ["${aws_security_group.ALLTRAFFIC.name}"]


connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("./terraform.pem")}"
      host = "${aws_instance.terraformmachine.public_ip}"
}

provisioner "remote-exec" {
        inline=[ "sudo apt-get update",
                 "sudo apt-get install tomcat7 -y",
                 "sudo chmod 777 /var/lib/tomcat7/webapps",
                ]
}
provisioner "file" {
    source      = "C:\\Program Files (x86)\\Jenkins\\workspace\\practice\\gameoflife-web\\target\\gameoflife.war"
    destination = "/var/lib/tomcat7/webapps/gameoflife.war"
  }
}

resource "aws_security_group" "ALLTRAFFIC" {
    name="ALLTRAFFIC"

    ingress {
        from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

egress {
       from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]

}
}
