# # Infrastructure demo for TFE interview
terraform {
  cloud {
    organization = "jamal-demo"
    
    workspaces {
      name = "terraform-tfe-demo"
    }
  }
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "tfe-demo-476501" 
  region = "us-central1"
}

resource "google_compute_network" "demo" {
  name                    = "tfe-demo-vpc-vcs"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "demo" {
  name          = "tfe-demo-subnet-vcs"
  ip_cidr_range = "10.200.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.demo.id
}


resource "google_compute_firewall" "allow_http" {
  name    = "tfe-demo-allow-http"
  network = google_compute_network.demo.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

output "vpc_name" {
  value = google_compute_network.demo.name
}

output "vpc_id" {
  value = google_compute_network.demo.id
}
