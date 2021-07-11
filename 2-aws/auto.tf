# create security group
resource "aws_security_group" "tf-asg-sg" {
  name        = "tf-asg-sgg"
  description = "Allow webASG inbound traffic"
  vpc_id      = aws_vpc.vpc-10-0-0-0.id

  ingress {
    description      = "tf-asg-sg from SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
/*    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]  */
  }

  ingress {
    description      = "tf-asg-sg from HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
/*    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]  */
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
/*    ipv6_cidr_bloc ks = ["::/0"] */
  }

  tags = {
    Name = "tf-asg-sg"
  }
}

resource "aws_security_group" "tf-asg-alb-sg" {
  name        = "tf-asg-alb-sg"
  description = "test inbound traffic"
  vpc_id      = aws_vpc.vpc-10-0-0-0.id

ingress {
    description      = "tf-asg-sg from SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
/*    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]  */
  }

  ingress {
    description      = "tf-asg-sg from HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
/*    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]  */
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "tf-asg-alb-sg"
  }
}

resource "aws_lb" "tf-asg-alb" {
  name               = "tf-asg-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf-asg-alb-sg.id]
  subnets            = [aws_subnet.sub-pub1-10-0-1-0.id, aws_subnet.sub-pub2-10-0-2-0.id]
  enable_deletion_protection = false
  tags = {
    Name = "tf-asg-alb-sg"
  }
}

resource "aws_lb_target_group" "tf-asg-alb-tg" {
  name     = "tf-asg-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   =  aws_vpc.vpc-10-0-0-0.id
  
    health_check {
          enabled             = true
          healthy_threshold   = 3
          interval            = 5
          matcher             = "200"
          path                = "/"
          port                = "traffic-port"
          protocol            = "HTTP"
          timeout             = 2
          unhealthy_threshold = 2
      }
}

resource "aws_lb_listener" "tf-asg-alb-in" {
  load_balancer_arn = aws_lb.tf-asg-alb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf-asg-alb-tg.arn
  }
}

resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = "ami-06e83aceba2cb0907"
  instance_type = "t2.micro"
#  iam_instance_profile = "som-Role"
  security_groups = [aws_security_group.tf-asg-sg.id]
  key_name = "dobbyisfree"
  user_data = file("./userdata.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "tf-asg" {
  name                      = "terraform-asg-example"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 5
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = [aws_subnet.sub-pri1-10-0-3-0.id, aws_subnet.sub-pri2-10-0-4-0.id]

  tag {
    key                 = "Name"
    value               = "tf-asg"
    propagate_at_launch =  true  /*  false -> true 해야 instance 이름출력 */
  }
} /*propagate_at_launch : EC2인스턴스 생성될 때마다 value값(tf-asg)읽어서 tag에 넣음*/
   

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.tf-asg.id
  alb_target_group_arn   = aws_lb_target_group.tf-asg-alb-tg.arn
}
