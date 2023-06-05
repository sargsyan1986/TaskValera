resource "aws_iam_role" "cloudwatch_agent_role" {
  name = "CloudWatchAgentRole"
  path = "/"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  # for_each = toset(local.role_policy_arns)

  role = aws_iam_role.cloudwatch_agent_role.name
  # policy_arn = each.key
}

