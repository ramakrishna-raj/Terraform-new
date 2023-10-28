## Create VPC

resource "aws_vpc" "application" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "rama-vpc"
  }
}
