provider "vsphere" {
  user           = var.vcsim_vc_user
  password       = var.vcsim_vc_pass
  vsphere_server = "34.69.0.68:8989"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "DC0"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore/LocalDS_0"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "DC0_H0/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "network/VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "terraform-test-01" {
  name             = "terraform-test-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  wait_for_guest_ip_timeout = false
  wait_for_guest_net_timeout = false

  num_cpus = 1
  memory   = 2048
  guest_id = "other3xLinux64Guest"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
}

resource "vsphere_virtual_machine" "terraform-test-02" {
  name             = "terraform-test-02"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  wait_for_guest_ip_timeout = false
  wait_for_guest_net_timeout = false

  num_cpus = 1
  memory   = 2048
  guest_id = "other3xLinux64Guest"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
}
