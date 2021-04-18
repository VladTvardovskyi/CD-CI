# terraform {
#   required_version = ">= 0.11.14"
# }
#
provider "aws" {
  # version = "~> 2.43.0"
  region = "eu-central-1"
}

# Creating access credentials for the user created in above step.
resource "aws_iam_access_key" "eksid" {
  user = aws_iam_user.eksuser.name
}

resource "aws_iam_user" "eksuser" {
  name = "eks"
}

# # Creating policies for the user.
# resource "aws_iam_policy" "eksuserpolicy" {
#   name   = "EKSUserPolicy"
#   path   = "./"
#   policy = "user-policy.json"
# }
# resource "aws_iam_policy" "eksuserpolicy" {
#   name        = "EKSUserPolicy"
#   path        = "/"
#   description = "EKSUserPolicy"
#   policy      = <<EOT
#   {
#       "Version": "2012-10-17",
#       "Statement": [
#           {
#               "Effect": "Allow",
#               "Action": "*",
#               "Resource": "*"
#           }
#       ]
#   }
# EOT
# }
# # Attaching the policies with the user.
# resource "aws_iam_user_policy_attachment" "eksuserpolicyattachement" {
#   user = aws_iam_user.eksuser.name
#    policy_arn = aws_iam_policy.eksuserpolicy.arn
# }
