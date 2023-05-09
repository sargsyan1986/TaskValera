resource "aws_instance" "inst1" {

  # ami                    = "ami-06e46074ae430fba6"
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.micro"
  key_name               = "banali2"
  vpc_security_group_ids = [aws_security_group.imSG.id]
  user_data              = file("script.sh")

  tags = {
    Name = "example-instance"
  }

}
