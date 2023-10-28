## Create VPC

resource "aws_vpc" "application" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "rama-vpc"
  }
}

# Create Public subnet AZ-A

resource "aws_subnet" "application-pub-sn-A" {
  vpc_id     = aws_vpc.application.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-southeast-2a"
  tags = {
    Name = "rama-pub-sn-A"
  }
}
