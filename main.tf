terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Main region for IAM roles
}

provider "github" {} # Takes the default GitHub token from the environment variable GITHUB_TOKEN provided by the GitHub Actions runner.