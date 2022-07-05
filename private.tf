# resource "aws_instance" "private" {
#   ami                         = "ami-0d9858aa3c6322f73"
#   subnet_id                   = aws_subnet.private_subnet1.id
#   instance_type               = "t2.micro"
#   vpc_security_group_ids      = [aws_security_group.private.id]
#   associate_public_ip_address = true
#   key_name                    = "private"
#   tags = {
#     "Name" = "Private-EC2"
#   }
# }
# resource "aws_security_group" "private" {
#   name        = "Private"
#   description = "Allow access to private instance and outbound internet access"
#   vpc_id      = aws_vpc.main.id
#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     security_groups = [aws_security_group.bastion.id]
#   }
#    ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     #security_groups = [aws_security_group.bastion.id]
#   }
#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     security_groups = [aws_security_group.bastion.id]

#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

