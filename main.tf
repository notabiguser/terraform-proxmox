resource "proxmox_download_file" "ubuntu_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "pve"
  url          = var.ubuntu_image_url
  file_name    = "resolute-server-cloudimg-amd64.qcow2"
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each  = var.vms
  name      = each.key
  node_name = "pve"

  cpu {
    cores = each.value.cores
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-zfs"
    interface    = "scsi0"
    import_from  = proxmox_download_file.ubuntu_image.id
    size         = each.value.disk
  }

  network_device {
    bridge = "vmbr0" # VM bridge
  }

  initialization {
    datastore_id = "local-zfs"
    ip_config {
      ipv4 {
        address = each.value.ip
        gateway = "192.168.1.1"
      }
    }
    user_account {
      username = "ubuntu"
      keys     = [var.ssh_public_key]
    }
  }

  operating_system {
    type = "l26" # Linux
  }
}
