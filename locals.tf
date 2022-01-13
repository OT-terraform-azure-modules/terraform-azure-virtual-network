locals {
  if_ddos_enabled = var.create_ddos_protection_plan ? [{}] : []
}
