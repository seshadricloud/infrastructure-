#alb-sg

resource "aws_security_group" "alb" {
  name        = "alb"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.petclinic.id

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-albsg"
  }
}

resource "aws_lb" "apache-alb" {
  name               = "apache-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = ["${aws_subnet.pubsubnets[1].id}", "${aws_subnet.pubsubnets[2].id}"]

  enable_deletion_protection = true


  tags = {
    Environment = "dev"
  }
}


# instance target group

resource "aws_lb_target_group" "apache-tg" {
  name     = "apache-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.petclinic.id
}



resource "aws_lb_target_group_attachment" "attach-tg" {
  target_group_arn = aws_lb_target_group.apache-tg.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}

# listner


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.apache-alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache-tg.arn
  }
}

#route53


resource "aws_route53_zone" "kkmn-hostedzone" {
  name = "kkmn.info"

  tags = {
    Environment = "dev"
  }
}



resource "aws_route53_record" "apache2" {
  zone_id = aws_route53_zone.kkmn-hostedzone.zone_id
  name    = "apache2.kkmn.info"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.nateip.public_ip]
}

