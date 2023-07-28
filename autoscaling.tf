provider "aws" {
  region = "eu-north-1"  
}
resource "aws_vpc" "don_vpc" {
  cidr_block = "10.0.0.0/16"  

  tags = {
    Name = "don-VPC-3"  
  }
}

resource "aws_subnet" "don_vpc_subnet" {
  vpc_id            = aws_vpc.don_vpc.id
  cidr_block        = "10.0.1.0/24"  
  availability_zone = "eu-north-1a"  

  tags = {
    Name = "don-VPC-3-Subnet"  
  }
}

resource "aws_security_group" "don_sg" {
  name_prefix = "don-sg-3"
  vpc_id      = aws_vpc.don_vpc.id
}

resource "aws_launch_configuration" "don_launch_config" {
  name_prefix     = "don-lc"
  image_id        = "ami-05c49a63441937596"  
  instance_type   = "t3.micro"  
  security_groups = [aws_security_group.don_sg.id]
}
# Define the launch configuration for EC2 instances
resource "aws_autoscaling_group" "don_asg" {
  name                 = "don-asg"
  max_size             = 3
  min_size             = 1
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.don_launch_config.name
  vpc_zone_identifier  = [aws_subnet.don_vpc_subnet.id]

  tag {
    key                 = "Name"
    value               = "ExampleInstance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "don_scale_out_policy" {
  name                   = "don-scale-out"
  autoscaling_group_name  = aws_autoscaling_group.don_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
}

resource "aws_autoscaling_policy" "don_scale_in_policy" {
  name                   = "don-scale-in"
  autoscaling_group_name  = aws_autoscaling_group.don_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
}