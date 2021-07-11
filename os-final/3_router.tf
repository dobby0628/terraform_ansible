# Create router
resource "openstack_networking_router_v2" "test-router" {
  name                = "test-router"
  admin_state_up      = true
  external_network_id = "${openstack_networking_network_v2.external_network.id}"
  enable_snat         = "true"
}

# Connect router and internal network
resource "openstack_networking_router_interface_v2" "router_interface_2" {
  router_id = "${openstack_networking_router_v2.test-router.id}"
  subnet_id = "${openstack_networking_subnet_v2.internal_network_subnet.id}"
}
