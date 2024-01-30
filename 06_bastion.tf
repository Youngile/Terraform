#EC2 생성

resource "aws_instance" "my_bastion_ec2" {
  ami           = "ami-01123b84e2a4fba05"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Public_subnet_a.id
  key_name = "KYI_pem"
  vpc_security_group_ids = [aws_security_group.my_bastion_alb_sg.id]
  associate_public_ip_address = true
  disable_api_termination = true
  root_block_device {
    volume_size = "20"
    volume_type = "gp3"
    delete_on_termination = true
  tags = {
    Name = "my_bastion_ec2"
    }
  }
}

