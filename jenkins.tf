#jenkins.tf

resource "aws_lb" "jenkins-alb" {
  name               = "jenkins-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = ["${aws_subnet.pubsubnets[1].id}", "${aws_subnet.pubsubnets[2].id}"]

  enable_deletion_protection = true


  tags = {
    Environment = "stg"
  }
}


# instance target group

resource "aws_lb_target_group" "jenkins-tg" {
  name     = "jenkins-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.petclinic.id
}



resource "aws_lb_target_group_attachment" "testing" {
  target_group_arn = aws_lb_target_group.jenkins-tg.arn
  target_id        = aws_instance.jenkins.id
  port             = 8080
}





# listner


resource "aws_lb_listener" "r_end" {
  load_balancer_arn = aws_lb.jenkins-alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins-tg.arn
  }
}

#jenkinsuserdata

data "template_file" "userdata1" {
  template = "${file("jenkinsuserdata.sh")}"

}


#jenkins instance

resource "aws_instance" "jenkins" {
  ami           = var.ami
  instance_type = var.type
  key_name = aws_key_pair.krishna1.id
  vpc_security_group_ids = ["${aws_security_group.tomcat.id}"]
  subnet_id = aws_subnet.privsubnets[1].id
  user_data = data.template_file.userdata1.rendered

  tags = {
    Name = "${var.envname}-jenkins"
  }
}



resource "aws_route53_record" "jenkins" {
  zone_id = aws_route53_zone.kkmn-hostedzone.zone_id
  name    = "jenkins.kkmn.info"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.nateip.public_ip]
}