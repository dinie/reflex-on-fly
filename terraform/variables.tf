variable "cloudflare_token" {
  description = "CF Pages API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "ZoneID"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Account ID"
  type        = string
}

variable "cloudflare_project_name" {
  description = "Used to identify CF Pages and reused in domain"
  type        = string
}
