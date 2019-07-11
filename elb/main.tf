resource "aws_acm_certificate" "cert" {
  domain_name       = "terraform.com"
  validation_method = "DNS"
}

data "aws_route53_zone" "external" {
  name = "terraform.com"
}
resource "aws_route53_record" "validation" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.external.zone_id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = "60"

}
resource "aws_acm_certificate_validation" "default" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.validation.fqdn}"]
}
resource "aws_lb" "test" {
  name               = "testlb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-0a25656d", "subnet-36561918"]
  security_groups    = ["sg-0d609a926f98b3043"]
  depends_on         = ["aws_instance.terraformmachine", "aws_instance.terraformmachine2"]
}


resource "aws_alb_target_group" "albtarget" {
  name     = "albtarget"
  port     = "443"
  protocol = "HTTPS"
  vpc_id   = "vpc-ac35a8d6"

  health_check {
    path                = "/mani.html"
    port                = "80"
    protocol            = "HTTPS"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}



resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = "80"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  protocol          = "HTTPS"

  default_action {
    target_group_arn = "${aws_alb_target_group.albtarget.arn}"
    type             = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}


resource "aws_lb_listener_certificate" "example" {

  listener_arn    = "${aws_lb_listener.front_end.arn}"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  depends_on      = ["aws_acm_certificate.cert"]
}

resource "aws_alb_target_group_attachment" "instance1" {
  target_group_arn = "${aws_alb_target_group.albtarget.arn}"
  target_id        = "${aws_instance.terraformmachine.id}"
  port             = 80
}
resource "aws_alb_target_group_attachment" "instance2" {
  target_group_arn = "${aws_alb_target_group.albtarget.arn}"
  target_id        = "${aws_instance.terraformmachine2.id}"
  port             = 80
}
