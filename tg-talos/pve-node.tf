resource "proxmox_virtual_environment_vm" "this" {
  count = var.nodes

  name            = netbox_virtual_machine.this[count.index].name
  description     = "Managed by Undercloud (Terraform)"
  tags            = ["kubernetes", "terraform"]
  node_name       = data.proxmox_virtual_environment_nodes.available_nodes.names[count.index] # This is kinda stupid
  started         = true
  on_boot         = false
  stop_on_destroy = true

  clone {
    vm_id        = 9201 # todo find template id
    node_name    = "pve1"
    datastore_id = var.datastore
  }

  cpu {
    cores = var.cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  agent {
    enabled = true
    timeout = "2m"
  }

  disk {
    datastore_id = var.datastore
    interface    = "scsi0"
    size         = var.disk
    iothread     = true
  }

  initialization {
    # Talos Machine config
    user_data_file_id = proxmox_virtual_environment_file.this[data.proxmox_virtual_environment_nodes.available_nodes.names[count.index]].id

    datastore_id = var.datastore
    interface    = "ide1"

    dns {
      domain = var.domain_name
      server = var.nameservers[0]
    }

    ip_config {
      ipv6 {
        address = netbox_available_ip_address.this[count.index].ip_address
        gateway = cidrhost(var.netbox_node_prefix, 1)
      }
    }
  }

  network_device {
    bridge  = var.vm_brige
    vlan_id = data.netbox_vlan.this.vid
  }

  smbios {
    serial = "h=${netbox_virtual_machine.this[count.index].name}"
  }

  lifecycle {
    ignore_changes = [
      node_name,
      started,
      initialization
    ]
  }
}