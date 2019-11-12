variable "count" {
  description = "number of instances to launch" 
  default = "1"
}

variable "rds_name" {
  description = "RDS instance name"
  default = "devopsdemo-db"
}

variable "rds_pass" {
  description = "RDS password"
  default = "12345678"
}

variable "ami" {
  description = ""
  default = "ami-0c5199d385b432989"
}

variable "instance" {
  description = ""
  default = {
    "type" = "t2.micro"
  }
}

variable "key" {
  description = ""
  default = {
    "name" = "terraform"
    "pub"  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3ozOQVNXcZUqmJVWGVD4BnANSdX9bPCTODHHt+Cl8QK7LIstoKIMKnOVjo28JQYdQamxxed1g9TR6WGVR0Of0E8EGINmpjgm2yCVdWoq56NNTXa40eWzjD66XYUzrEiia9MuFKBwjkO++ErR8DlGQ84XiiIo215hmviBrwOlu5NOqTsT6HzqnqjI/qY47yIVSvSovGRyrQRbK6P0yPzR105y0CQ5e5/XPa5/g+y03YQYo7N/Mjmr/xJB9hE8CgzmaQUsM9276ckDvr/CaBheNyqzdT9rvqd1bWPy5pkA2og7ZwdNtwNAtEFPTbGNaZkO9IoO0yNgT36p5s1QOoH2f gouravshah@Apples-MacBook-Pro-2.local"
  }

}

variable "tags" {
  description = ""
  default = {
    "name" = "tf-frontend-01"
    "app"  = "devops-demo"
    "maintainer" = "Gourav Shah"
    "role" = "frontend"
  }
}

