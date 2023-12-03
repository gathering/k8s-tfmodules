terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.39.0"
    }
    netbox = {
      source  = "e-breuninger/netbox"
      version = "3.7.5"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.4.0-alpha.0"
    }
  }
}