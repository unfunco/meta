terraform {
  required_version = ">= 1.6.0"
}

variable "name" {
  type    = string
  default = "workflow"
}

output "greeting" {
  value = "Hello, ${var.name}!"
}
