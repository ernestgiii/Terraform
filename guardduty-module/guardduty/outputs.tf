output "guardduty_detector_id" {
  description = "The ID of the GuardDuty detector"
  value       = aws_guardduty_detector.MyDetectiveDetector.id
}

output "sns_topic_arn" {
  value = aws_sns_topic.guardduty_alerts.arn
}