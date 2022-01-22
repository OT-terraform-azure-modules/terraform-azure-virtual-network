#terraform_documented_outputs
output "no_description" {
  value = "value" #error for not having discription
}

output "empty_description" {
  value = "value"
  description = "" ##error for having blank discription
}

output "description" {
  value = "value"
  description = "This is description" # no error
}
