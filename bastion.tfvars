#bastion.tfvars

region = "ap-northeast-1"
cidr = "10.1.0.0/16"
envname = "tera-dev"
pubsubnets = ["10.1.0.0/24","10.1.1.0/24","10.1.2.0/24"]
privsubnets = ["10.1.3.0/24","10.1.4.0/24","10.1.5.0/24"]
datasubnets = ["10.1.6.0/24","10.1.7.0/24","10.1.8.0/24"]
azs = ["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
ami = "ami-09ebacdc178ae23b7"
type = "t2.micro"
