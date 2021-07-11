# Create floating ip and Connect lb
resource "openstack_networking_floatingip_v2" "floatip_3" {
  pool = "${openstack_networking_network_v2.external_network.name}"
}

resource "openstack_networking_floatingip_associate_v2" "fip_3" {
  floating_ip = "${openstack_networking_floatingip_v2.floatip_3.address}"
  port_id     = "${openstack_lb_loadbalancer_v2.centos_lb.vip_port_id}"
}
