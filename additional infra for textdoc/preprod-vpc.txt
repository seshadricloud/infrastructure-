module "preprod" {
      source ="../vpc/"
      region = "ap-northeast-1"
      cidr = "10.3.0.0/16"
      envname = "tera-preprod"
      pubsubnets = ["10.3.0.0/24","10.3.1.0/24","10.3.2.0/24"]
      privsubnets = ["10.3.3.0/24","10.3.4.0/24","10.3.5.0/24"]
     datasubnets = ["10.3.6.0/24","10.3.7.0/24","10.3.8.0/24"]
     azs = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
}
