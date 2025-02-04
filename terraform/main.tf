# Security Group
resource "aws_security_group" "cerebro-sec-grp" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress{
    description = "HTTPS"
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "HTTP"
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "SSH"
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  description = "Cerebro Application"
  from_port   = 8000
  to_port     = 8000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  
}

ingress {
  description = "PostgreSQL Access"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] 
}

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Cerebro_Sec_Grp"
  }
}

resource "aws_security_group" "apache-sec-grp" {
  name        = "allow_tls_apache"
  description = "Allow TLS inbound traffic and all outbound traffic"

  ingress{
    description = "HTTPS"
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "HTTP"
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    description = "SSH"
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  description = "Alternative port"
  from_port   = 8000
  to_port     = 8000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  
}


  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Apache_Sec_Grp"
  }
}


# Setup Server
resource "aws_instance" "cerebro-server-instance"{
    ami = var.ami
    instance_type = var.instance_type
    availability_zone = var.zone
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.cerebro-sec-grp.id]

   tags = {
    Name = "cerebro-server"
   } 
}

resource "aws_instance" "apache_web_server"{
    ami = var.ami
    instance_type = var.instance_type
    availability_zone = var.zone
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.apache-sec-grp.id]

   tags = {
    Name = "apache-web-server"
   } 
}