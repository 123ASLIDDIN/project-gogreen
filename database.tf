

resource "aws_db_instance" "project-1" {
  allocated_storage    = 20
  identifier           = "mysql-db-01"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "db_name"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  availability_zone    = "us-east-1a"
  port                 = "3306"
  #subnet_group       = "aws_db_subnet_group.db-subnet1"
}

resource "aws_db_instance" "project-2" {
  allocated_storage    = 20
  identifier           = "mysql-db-02"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "db_name"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  availability_zone    = "us-east-1b"
  port                 = "3306"
  #subnet_group        = "aws_db_subnet_group.db-subnet2"
}

## CREATING SUBNET GROUPS
resource "aws_db_subnet_group" "db-subnet1" {
  name       = "dbsg-1"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  tags = {
    Name = "My DB subnet group1"
  }
}

resource "aws_db_subnet_group" "db-subnet2" {
  name       = "dbsg-2"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  tags = {
    Name = "My DB subnet group2"
  }
}
# Create Security Group for Database
# terraform aws create security group
resource "aws_security_group" "SecurityGroupDB" {
  name        = "Database Security Group"
  description = "Enable MySQL on Port 3306"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL Access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver-security-group.id]
  }
  ingress {
    description     = "MySQL Access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.appserver-security-group.id]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SecurityGroupDB Security Group"
  }
}




resource "aws_ssm_parameter" "password" {
  name  = "admin"
  type  = "String"
  value = "password"
}
# resource "aws_db_instance" "default" {
#   allocated_storage    = 10
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "5.7.16"
#   instance_class       = "db.t2.micro"
#   name                 = "mydb"
#   username             = "foo"
#   password             = "${var.database_master_password}"
#   db_subnet_group_name = "my_database_subnet_group"
#   parameter_group_name = "default.mysql5.7"
# }

# resource "aws_ssm_parameter" "secret" {
#   name  = "${var.environment}/database/password/master"
#   description  = "The parameter description"
#   type  = "SecureString"
#   value = "${var.database_master_password}"

#   tags {
#     environment = "${var.environment}"
#   }
# }

