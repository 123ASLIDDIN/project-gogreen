resource "aws_sns_topic" "EC2_STATE" {
  name = "EC2_STATE_CHANGE"
}
resource "aws_sns_topic_subscription" "ec2_sns_target" {
  topic_arn = aws_sns_topic.EC2_STATE.arn
  protocol  = "email"
  endpoint  = "gulshantoirjonova@gmail.com"
}
resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.EC2_STATE.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}
data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sns_topic.EC2_STATE.arn]
  }
}
resource "aws_cloudwatch_event_rule" "console" {
  name          = "ec2-state-change"
  description   = "Send notifications to SNS when EC2 state change"
  event_pattern = <<PATTERN
{
"source": ["aws.ec2"],
"detail-type": ["EC2 Instance State-change Notification"],
"detail": {
"state": ["pending", "running", "terminated"]
}
}
PATTERN
}
resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.console.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.EC2_STATE.arn
}