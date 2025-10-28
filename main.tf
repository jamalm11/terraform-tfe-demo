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
  name                    = "tfe-demo-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "demo" {
  name          = "tfe-demo-subnet"
  ip_cidr_range = "10.100.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.demo.id
}


output "vpc_name" {
  value = google_compute_network.demo.name
}

output "vpc_id" {
  value = google_compute_network.demo.id
}
