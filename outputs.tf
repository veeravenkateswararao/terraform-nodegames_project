output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "application_url" {
  value = "http://app.${var.domain_name}"
}