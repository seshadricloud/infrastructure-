module "prod" {
      source ="../vpc/"
      region = "ap-northeast-1"
      cidr = "10.4.0.0/16"
      envname = "tera-prod"
      pubsubnets = ["10.4.0.0/24","10.4.1.0/24","10.4.2.0/24"]
      privsubnets = ["10.4.3.0/24","10.4.4.0/24","10.4.5.0/24"]
     datasubnets = ["10.4.6.0/24","10.4.7.0/24","10.4.8.0/24"]
     azs = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
}
