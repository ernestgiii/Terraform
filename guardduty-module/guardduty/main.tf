resource "aws_guardduty_detector" "MyDetectiveDetector" {
  enable                       = var.enable
}

resource "aws_sns_topic" "guardduty_alerts" {
  name = "guardduty-alerts"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.guardduty_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email 
}

resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  name        = "guardduty-findings-rule"
  description = "Triggered on GuardDuty findings"
  event_pattern = jsonencode({
    source = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
  })
}

resource "aws_cloudwatch_event_target" "send_to_sns" {
  rule      = aws_cloudwatch_event_rule.guardduty_findings.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.guardduty_alerts.arn
}

resource "aws_sns_topic_policy" "sns_policy" {
  arn    = aws_sns_topic.guardduty_alerts.arn
  policy = data.aws_iam_policy_document.sns_publish.json
}

data "aws_iam_policy_document" "sns_publish" {
  statement {
    actions   = ["SNS:Publish"]
    effect    = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sns_topic.guardduty_alerts.arn]
  }
}
