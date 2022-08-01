

# resource "aws_iam_role_policy_attachment" "participant_dynamo_rw" {
# #   role = aws_iam_role.exec_role.name
#   role = module.resource_participant.exec_role_name
#   policy_arn = aws_iam_policy.dynamodb_rw.arn
# }