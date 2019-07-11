provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_accesskey}"
  secret_key = "${var.aws_secretkey}"
}

resource "aws_launch_configuration" "launch_conf" {
  name_prefix   = "terraform-launch"
  image_id      = "ami-024a64a6685d05041"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_policy" "aws_as_policy" {
  name                   = "terraform-test-policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
}
resource "aws_autoscaling_group" "asg" {
  name                 = "terraform-asg-example"
  launch_configuration = "${aws_launch_configuration.launch_conf.name}"
  min_size             = 1
  max_size             = 2
  availability_zones   = ["us-east-1a"]

}
