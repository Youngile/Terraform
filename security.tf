#보안그룹 기본 생성 방식

resource "aws_security_group" "my_web_alb_sg" {
  vpc_id = "${aws_vpc.my_vpc.id}"     #생성할 위치의 VPC ID
  name = "my_web_alb_sg"              #그룹 이름
  description = "web_alb_sg"          #설명
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_app_alb_sg" {
  vpc_id = "${aws_vpc.my_vpc.id}"     #생성할 위치의 VPC ID
  name = "my_app_alb_sg"              #그룹 이름
  description = "app_alb_sg"          #설명
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "my_app_alb_sg" {
    type = "ingress"  
    from_port = 80                    #인바운드 시작 포트
    to_port = 80                      #인바운드 끝나는 포트
    protocol = "tcp"                  #사용할 프로토콜
    source_security_group_id = aws_security_group.my_web_alb_sg.id
    security_group_id        = aws_security_group.my_app_alb_sg.id
  
}

resource "aws_security_group" "my_db_alb_sg" {
  vpc_id = "${aws_vpc.my_vpc.id}"     #생성할 위치의 VPC ID
  name = "my_app_db_sg"              #그룹 이름
  description = "app_db_sg"          #설명
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "my_db_alb_sg" {
    type = "ingress"  
    from_port = 3306                  #인바운드 시작 포트
    to_port = 3306                    #인바운드 끝나는 포트
    protocol = "tcp"                  #사용할 프로토콜
    source_security_group_id = aws_security_group.my_app_alb_sg.id
    security_group_id        = aws_security_group.my_db_alb_sg.id
  
}
