terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Symmetry"

    workspaces {
      name = "tfc-vcsim-lab-1"
    }
  }
}
