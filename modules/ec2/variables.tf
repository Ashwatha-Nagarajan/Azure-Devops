variable "ami" {
  type = map
  default = {
      "us-east-1" = "ami-079ca844e323047c2"
      "us-east-2" = "ami-0960ab670c8bb45f3"
  }
}

variable "region" {
  default = "us-east-1"
}
variable "instance-type" {
  default = "t2.micro"
}

 variable "vpc_id" {
   
 }
 variable "public_subnet_ids" {
   
 }
