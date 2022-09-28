module "aws_vpc" {
  source = "../modules/vpc"
}

module "aws_ec2" {
    source = "../modules/ec2"
    vpc_id = data.aws_vpc.aws_vpc_id.id
    public_subnet_ids = data.aws_subnets.an_pub_subnets.ids 
}

resource "aws_db_instance" "An-db" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "username"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = "${aws_db_subnet_group.db-subnet.name}"
  vpc_security_group_ids = [module.aws_ec2.db-sec-group]
}

resource "aws_db_subnet_group" "db-subnet" {
  name = "db-subnet-group"
  subnet_ids = [module.aws_vpc.subnet-2, module.aws_vpc.subnet-3]
}





