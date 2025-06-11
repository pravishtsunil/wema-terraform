terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
		}
	}

	backend "remote" {
		hostname = "app.terraform.io"
		organization = "Pravisht"

		workspaces {
			name = "wema-terraform-workspace"
		}
	}
}

provider "aws" {
	region = "us-east-1"
}