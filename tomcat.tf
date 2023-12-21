#tomcat.tf


resource "aws_lb_target_group" "tomcat-tg" {
  name     = "tomcat-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.petclinic.id
}



resource "aws_lb_target_group_attachment" "testing1" {
  target_group_arn = aws_lb_target_group.tomcat-tg.arn
  target_id        = aws_instance.tomcat1.id
  port             = 8080
}

data "template_file" "userdata2" {
  template = "${file("tomcatuserdata.sh")}"

}


resource "aws_instance" "tomcat1" {
  ami           = var.ami
  instance_type = var.type
  key_name = aws_key_pair.krishna1.id
  vpc_security_group_ids = ["${aws_security_group.tomcat.id}"]
  subnet_id = aws_subnet.privsubnets[0].id
  user_data = data.template_file.userdata2.rendered

  tags = {
    Name = "${var.envname}-tomcat1"
  }
}





# listner


resource "aws_lb_listener" "r_end1" {
  load_balancer_arn = aws_lb.jenkins-alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins-tg.arn
  }
}

resource "aws_route53_record" "tomcat1" {
  zone_id = aws_route53_zone.kkmn-hostedzone.zone_id
  name    = "tomcat.kkmn.info"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.nateip.public_ip]
}

