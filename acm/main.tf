resource "aws_acm_certificate" "acm_cert" {
  domain_name               = "${var.domain_names[0]}"
  validation_method         = "DNS"
  subject_alternative_names = "${slice(var.domain_names, 1, length(var.domain_names))}" // For SAN this takes from domain_names[1]

  tags = "${var.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_validation_records" {
  count   = "${length(var.domain_names)}"
  zone_id = "${var.zone_id}"
  name    = "${lookup(aws_acm_certificate.acm_cert.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.acm_cert.domain_validation_options[count.index], "resource_record_type")}"
  records = ["${lookup(aws_acm_certificate.acm_cert.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = "${var.validation_record_ttl}"
}

resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn         = "${aws_acm_certificate.acm_cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.acm_validation_records.*.fqdn}"]
}
