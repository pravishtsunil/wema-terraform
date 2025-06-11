variable "role_name" {
  type        = string
  description = "Specifies the name of the resource group that will be created."
}
variable "region" {
  type        = string
  description = "The AWS region where the IAM role will be created."
  default     = "us-east-1"
}