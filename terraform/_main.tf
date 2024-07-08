terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.9.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

# Step 3: Create the Cloudflare Pages Project
resource "cloudflare_pages_project" "basic_project" {
  account_id        = var.cloudflare_account_id
  name              = var.cloudflare_project_name
  production_branch = "main"
}


# Step 4: Create DNS Record for Validation
resource "cloudflare_record" "record_validation" {
  zone_id         = var.cloudflare_zone_id
  name            = var.cloudflare_project_name
  value           = cloudflare_pages_project.basic_project.name
  type            = "CNAME"
  ttl             = 1
  proxied         = true
  allow_overwrite = false
}

# Step 5: Link Domain to Cloudflare Pages Project
resource "cloudflare_pages_domain" "this" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.basic_project.name
  domain       = "${var.cloudflare_project_name}.arulnathan.org"
}
