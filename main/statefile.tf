terraform {
  backend "s3" {
    bucket       = "github-terraform-bucket-amitu"
    key          = "infra.tfstate"
    region       = "us-east-1"
    use_lockfile = "true"
  }
}
