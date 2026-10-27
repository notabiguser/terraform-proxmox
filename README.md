# terraform-proxmox

IaC for Proxmox VMs using Terraform

### Add Terraform user and role

Run on the Proxmox host:

```bash
pveum user add terraform@pve
pveum role add Terraform -privs "Datastore.Allocate,Datastore.AllocateSpace,Datastore.AllocateTemplate,Datastore.Audit,SDN.Audit,SDN.Use,Sys.Audit,Sys.Modify,VM.Allocate,VM.Audit,VM.Config.CDROM,VM.Config.CPU,VM.Config.Cloudinit,VM.Config.Disk,VM.Config.HWType,VM.Config.Memory,VM.Config.Network,VM.Config.Options,VM.GuestAgent.Audit,VM.PowerMgmt"
pveum acl modify / --users terraform@pve --roles Terraform
pveum user token add terraform@pve provider --privsep 0
```

### Usage

```bash
cp terraform.tfvars.example terraform.tfvars
```

Put the api token in `terraform.tfvars` as `terraform@pve!provider=<value>`

```bash
terraform init
terraform apply
```
