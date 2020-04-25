# Terrform module for Amazon Certificate Manager (ACM) with Route 53 DNS validation.

## Usage

```hcl
module "acm_cert"
    source = "https://github.com/Aravee/terrform-modules/acm"
    domain_names = ["thesre.in", "www.thesre.in"]
    hosted_zone_id = "${aws_route53_zone.default.zone_id}"
    validation_record_ttl = 60

    tags = {
        Name = "website-acm"
        environment = "prod"
        terrafrom = true
    }       
```

## Variables

`domain_names` - Primary domain and All other Subject Alternative Names(goes here as a list).
`tags` - Used for tagging the ACMs (goes here as a map).
`hosted_zone_id` -  Hosted Zone Id of the domain name.
`validation_record_ttl` - Route 53 record time-to-live (TTL) for validation record (default: `60`).

## Outputs

- `acm_arn` - The Amazon Resource Name (ARN) of the ACM certificate.