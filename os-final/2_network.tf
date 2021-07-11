# Create external network
resource "openstack_networking_network_v2" "external_network" {
  name           = "external_network"
  admin_state_up = "true"
  shared         = "true"
  external       = "true"
  segments {
    physical_network = "extnet"
    network_type     = "flat"
  }
}

resource "openstack_networking_subnet_v2" "external_network_subnet" {
  name       = "external_network_subnet"
  network_id = "${openstack_networking_network_v2.external_network.id}"
  cidr       = "192.168.1.0/24"
  ip_version = 4
  dns_nameservers = ["8.8.8.8"]
  allocation_pool {
    start = "192.168.1.151"
    end   = "192.168.1.159"
  }
}

# Create internal network
resource "openstack_networking_network_v2" "internal_network" {
  name           = "internal_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "internal_network_subnet" {
  name       = "internal_network_subnet"
  network_id = "${openstack_networking_network_v2.internal_network.id}"
  cidr       = "100.100.100.0/24"
  ip_version = 4
  dns_nameservers = ["8.8.8.8"]
}

