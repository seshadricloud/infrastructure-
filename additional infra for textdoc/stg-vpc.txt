module "stage" {
      source ="../vpc/"
      region = "ap-northeast-1"
      cidr = "10.2.0.0/16"
      envname = "tera-dev"
      pubsubnets = ["10.2.0.0/24","10.2.1.0/24","10.2.2.0/24"]
      privsubnets = ["10.2.3.0/24","10.2.4.0/24","10.2.5.0/24"]
     datasubnets = ["10.2.6.0/24","10.2.7.0/24","10.2.8.0/24"]
     azs = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
}
