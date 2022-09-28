data "aws_subnets" "an_pri_subnets" {
  
  filter {
    name   = "vpc-id"
    values = [module.aws_vpc.vpc_id]
  }

  tags = {
    Tier = "Private"
  }
}

data "aws_subnets" "an_pub_subnets" {
  
  filter {
    name   = "vpc-id"
    values = [module.aws_vpc.vpc_id]
  }

  tags = {
    Tier = "Public"
  }
}

data "aws_vpc" "aws_vpc_id" {
  id = module.aws_vpc.vpc_id
}