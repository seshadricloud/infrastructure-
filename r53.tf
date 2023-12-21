#r53.tf

resource "aws_route53_zone" "kkmn-hostedzone" {
  name = "kkmn.info"

  tags = {
    Environment = "dev"
  }
}



resource "aws_route53_record" "apache3" {
  zone_id = aws_route53_zone.kkmn-hostedzone.zone_id
  name    = "apache3.kkmn.info"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.nateip.public_ip]
}