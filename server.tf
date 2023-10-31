# Create Security Groups

resource "aws_security_group" "application-SG" {
  name        = "rama-SG"
  description = "Allow SSH & HTTP traffic"
  vpc_id      = aws_vpc.application.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rama-SG"
  }
}

# Create ec2 instance

resource "aws_instance" "application-ec2" {
  ami           = "ami-0d02292614a3b0df1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.application-pub-sn-A.id
  key_name = "sydney.new"
  vpc_security_group_ids = [aws_security_group.application-SG.id]
  user_data = file("web.sh")

  tags = {
    Name = "rama-new"
  }
}
