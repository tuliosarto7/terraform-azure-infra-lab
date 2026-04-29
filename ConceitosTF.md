# Terraform Files

- Providers = tipos de integração / qual a cloud
- Resource = quais os recursos serao provisionados
- Initialization 
- Apply
- State
- Variables
- Provisioner
- Destroy

# Terraform commands
- init = carregar as dependências utilizadas 
- plan = vai fazer uma checagem e criar um plano de execução
- apply 
- destroy = excluir todo o ambiente provisionado
- import 


> terraform.state
 - Arquivo que contém tudo que foi feito e como está da ultima vez que foi alterado
 - Fica local na máquina
 - Ideal é criar um local para guardar o versionamento e alterações, por exemplo um storage no Azure ou S3 na AWS

 # EXEMPLO 

 terraform {
  backend "azurerm" {
    resource_group_name = ""
    storage_account_name = ""
    container_name = ""
    key = ""
  }
}