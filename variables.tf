variable "proxmox_api_url" {
  type        = string
  description = "Proxmox API URL, e.g., https://proxmox.example.com:8006"
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "API token id in the format terraform@pve!provider=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

variable "ubuntu_image_url" {
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/resolute/release-20261016/ubuntu-26.04-server-cloudimg-amd64.img"
  description = "URL to the Ubuntu cloud image to be downloaded"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
}

variable "vms" {
  type = map(object({
    cores  = number
    memory = number
    disk   = number
    ip     = string
  }))
  default = {
    control-plane-1 = { cores = 4, memory = 4096, disk = 20, ip = "192.168.1.101/24" }
    control-plane-2 = { cores = 4, memory = 4096, disk = 20, ip = "192.168.1.102/24" }
    control-plane-3 = { cores = 4, memory = 4096, disk = 20, ip = "192.168.1.103/24" }
    worker-1        = { cores = 4, memory = 4096, disk = 20, ip = "192.168.1.104/24" }
  }
}
