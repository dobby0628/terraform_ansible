# Create instance web1
resource "openstack_compute_instance_v2" "web1" {
  name            = "web1"
  flavor_id       = "${openstack_compute_flavor_v2.t2_small.flavor_id}"
  key_pair        = "test"
  security_groups = ["${openstack_networking_secgroup_v2.web_secgroup.name}"]
  user_data = file("./httpd1.sh")

  block_device {
    uuid                  = "${openstack_blockstorage_volume_v3.CentOS7_vol.id}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  metadata = {
    this = "that"
  }

  network {
    name = "internal_network"
  }
}

# Create instance web2
resource "openstack_compute_instance_v2" "web2" {
  name            = "web2"
  flavor_id       = "${openstack_compute_flavor_v2.t2_small.flavor_id}"
  key_pair        = "test"
  security_groups = ["${openstack_networking_secgroup_v2.web_secgroup.name}"]
  user_data = file("./httpd2.sh")

  block_device {
    uuid                  = "${openstack_blockstorage_volume_v3.CentOS7_vol2.id}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }

  metadata = {
    this = "that"
  }

  network {
    name = "internal_network"
  }
}
