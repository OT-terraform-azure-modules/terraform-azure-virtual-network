
#terraform_documented_variables
variable "no_description" {
  default = "value"
}

#terraform_documented_variables
variable "empty_description" {
  default = "value"
  description = ""
}

#terraform_naming_convention
variable "vnet_Name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
  type        = string
}


#terraform_typed_variables
variable "no_type" {
  default = "value"
}

#terraform_unused_declarations
variable "not_used" {}
