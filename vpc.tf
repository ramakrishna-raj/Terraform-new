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
  map_public_ip_on_launch = "true"
  tags = {
    Name = "rama-pub-sn-A"
  }
}

# Create Public subnet AZ-B

resource "aws_subnet" "application-pub-sn-B" {
  vpc_id     = aws_vpc.application.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "ap-southeast-2b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "rama-pub-sn-B"
  }
}

# Create Private subnet AZ-A

resource "aws_subnet" "application-pvt-sn-A" {
  vpc_id     = aws_vpc.application.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "ap-southeast-2a"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "rama-pvt-sn-A"
  }
}

# Create Private subnet AZ-B

resource "aws_subnet" "application-pvt-sn-B" {
  vpc_id     = aws_vpc.application.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "ap-southeast-2b"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "rama-pvt-sn-B"
  }
}
