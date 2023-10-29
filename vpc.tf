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

# Create Internet Gateway

resource "aws_internet_gateway" "application-igw" {
  vpc_id = aws_vpc.application.id

  tags = {
    Name = "ramakrishna-igw"
  }
}

# Create Public Route Table

resource "aws_route_table" "application-pub-RT" {
  vpc_id = aws_vpc.application.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.application-igw.id
  }

  tags = {
    Name = "ramakrishna-pub-RT"
  }
}

# Create Private Route Table

resource "aws_route_table" "application-pvt-RT" {
  vpc_id = aws_vpc.application.id


  tags = {
    Name = "ramakrishna-pvt-RT"
  }
}

# Create Public-RT Aassociation

resource "aws_route_table_association" "application-pub-asc-A" {
  subnet_id      = aws_subnet.application-pub-sn-A.id
  route_table_id = aws_route_table.application-pub-RT.id
}


resource "aws_route_table_association" "application-pub-asc-B" {
  subnet_id      = aws_subnet.application-pub-sn-B.id
  route_table_id = aws_route_table.application-pub-RT.id
}

# Create Private-RT Aassociation

resource "aws_route_table_association" "application-pvt-asc-A" {
  subnet_id      = aws_subnet.application-pvt-sn-A.id
  route_table_id = aws_route_table.application-pvt-RT.id
}


resource "aws_route_table_association" "application-pvt-asc-B" {
  subnet_id      = aws_subnet.application-pvt-sn-B.id
  route_table_id = aws_route_table.application-pvt-RT.id
}

# Create Public NACL

resource "aws_network_acl" "application-pub-NACL" {
  vpc_id = aws_vpc.application.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "rama-pub-NACL"
  }
}

# Create Private NACL

resource "aws_network_acl" "application-pvt-NACL" {
  vpc_id = aws_vpc.application.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "rama-pvt-NACL"
  }
}

# Create Public NACL Association

resource "aws_network_acl_association" "application-pub-NACL-asc-A" {
  network_acl_id = aws_network_acl.application-pub-NACL.id
  subnet_id      = aws_subnet.application-pub-sn-A.id
}

resource "aws_network_acl_association" "application-pub-NACL-asc-B" {
  network_acl_id = aws_network_acl.application-pub-NACL.id
  subnet_id      = aws_subnet.application-pub-sn-B.id
}

# Create Private NACL Association

resource "aws_network_acl_association" "application-pvt-NACL-asc-A" {
  network_acl_id = aws_network_acl.application-pvt-NACL.id
  subnet_id      = aws_subnet.application-pvt-sn-A.id
}

resource "aws_network_acl_association" "application-pvt-NACL-asc-B" {
  network_acl_id = aws_network_acl.application-pvt-NACL.id
  subnet_id      = aws_subnet.application-pvt-sn-B.id
}
