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
			name = "WSwema-terraform-workspace"
		}
	}
}

provider "aws" {
	region = "us-east-1"
}