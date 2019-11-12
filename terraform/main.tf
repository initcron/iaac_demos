provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}


provider "aws" {
  region = "ap-southeast-1"
  alias  = "singapore"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.46.0"

  providers = {
    aws = "aws.singapore"
  }

  name = "devopsdemo"
  cidr = "10.0.0.0/16"

  public_subnet_suffix = "devopsdemoPubSub"
  private_subnet_suffix = "devopsdemoPvtSub"


  azs             = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  assign_generated_ipv6_cidr_block = true

  enable_nat_gateway = false
  single_nat_gateway = false

  public_subnet_tags = {
    Name = "devopsdemo-public"
  }

  tags = {
    Owner       = "Gourav Shah"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "devops-demo"
  }
}



resource "aws_instance" "frontend" {
  count = "${var.count}"
  provider = "aws.singapore"

  ami                     = "${var.ami}"
  instance_type           = "${var.instance["type"]}"
  key_name                = "${var.key["name"]}"
  subnet_id               = "${module.vpc.public_subnets[0]}"
  vpc_security_group_ids  = ["${aws_security_group.frontend.id}"]
  disable_api_termination = false 

  provisioner "file" {
    source = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("~/.ssh/terraform-ap")}"
    }
  }

  provisioner "remote-exec" {

    inline = [ 
      "chmod +x /tmp/user-data.sh",
      "/tmp/user-data.sh"
    ]    

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("~/.ssh/terraform-ap")}"
    }
  }


  tags {
    Name       = "${var.tags["name"]}"
    App        = "${var.tags["app"]}"
    Maintainer = "${var.tags["maintainer"]}"
    Role       = "${var.tags["role"]}"
  }

  depends_on = [ "aws_key_pair.terraform" ]

  lifecycle {
    prevent_destroy = false
  }

  timeouts {
    create = "7m"
    delete = "1h"
  }
}


resource "aws_key_pair" "terraform" {
  provider = "aws.singapore"
  key_name = "${var.key["name"]}"
  public_key = "${var.key["pub"]}"
}

resource "aws_security_group" "frontend" {
  name = "frontend"
  description = "Security configs  for Frontend App"
  provider = "aws.singapore" 
  vpc_id   = "${module.vpc.vpc_id}"
  ingress {
    cidr_blocks  = ["0.0.0.0/0"]
    from_port    = 22
    to_port      = 22
    protocol     = "tcp"
    description  = "Open SSH port to all"
  }

  ingress {
    cidr_blocks  = ["0.0.0.0/0"]
    from_port    = 80
    to_port      = 80
    protocol     = "tcp"
    description  = "Open HTTP port to all"
  }

  egress {
    from_port    = 0
    to_port      = 0
    protocol     = "-1"
    cidr_blocks  = ["0.0.0.0/0"] 
    description  = "allow all outgoing connections"
  }

  tags {
     role = "${var.tags["role"]}"
     app  = "${var.tags["app"]}"
  }
}



