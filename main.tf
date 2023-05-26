resource "aws_instance" "inst1" {

  ami                    = "ami-0715c1897453cabd1"
  instance_type          = "t2.micro"
  key_name               = "banali"
  vpc_security_group_ids = [aws_security_group.imSG.id]
  user_data              = file("script.sh")
  iam_instance_profile   = aws_iam_instance_profile.demo-profile.name


  tags = {
    Name = "example-instance"
  }

}

resource "aws_iam_instance_profile" "demo-profile" {
  name = "demo_profile"
  role = aws_iam_role.cloudwatch_agent_role.name
}


