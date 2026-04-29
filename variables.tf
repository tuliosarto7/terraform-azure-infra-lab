variable "locat" {
    default = "Canada Central"

}

variable "rg" {
    default = "learning-iac"
}

variable "vnet" {
    default = "vnet-learning-iac"
}

variable "vm" {
    default = "vm-iac"
}

variable "admin_password" {
    type = string
    sensitive = true
}