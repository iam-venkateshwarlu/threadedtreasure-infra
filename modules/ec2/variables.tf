variable "instance_type" {
    default = "t2.micro"
  
}
variable "key_name" {
  default = "vscode"
}

variable "project" {
    default = "learn-VPC" 
}
variable "environment" {
    default = "dev"  
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}
