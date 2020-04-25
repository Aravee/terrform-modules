output "acm_arn" {
  description = "The ARN of the issued ACM"
  value       = "${aws_acm_certificate.acm_cert.arn}"
}
