terraform {
  
  required_version = ">= 1.3" # Requires Terraform 1.3 or later

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Allows 5.0.x versions
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.0, <4.0" # Allows 3.x versions
    }
  }  

#   backend "s3" {
#             bucket = "my-terraform-state-bucket"
#             key    = "path/to/my/state/terraform.tfstate"
#             region = "us-east-1"
#   }


}

/*

The settings block in Terraform has been deprecated and removed as of Terraform version 0.13.

before terraform 0.13

settings {
    experiments = [module_variable_optional_attributes]
}

from 0.13 onwards

export TF_EXPERIMENTAL_FEATURES=module_variable_optional_attributes
terraform init
terraform apply

terraform apply -experimental-module-variable-optional-attributes

*/