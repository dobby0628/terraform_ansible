# Create loadbalancer
resource "openstack_lb_loadbalancer_v2" "centos_lb" {
  name		= "centos_lb"
  vip_subnet_id	= "${openstack_networking_subnet_v2.internal_network_subnet.id}"
}

# Create lb_listener
resource "openstack_lb_listener_v2" "listener_1" {
  name		  = "centos_lb_listener"
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.centos_lb.id}"

  insert_headers = {
    X-Forwarded-For = "true"
  }
}

# Create lb_pool
resource "openstack_lb_pool_v2" "pool_1" {
  name	      = "centos_lb_pool_1"
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = "${openstack_lb_listener_v2.listener_1.id}"
}

# Create lb_members
resource "openstack_lb_member_v2" "member_1" {
  subnet_id     = "${openstack_networking_subnet_v2.internal_network_subnet.id}"
  pool_id       = "${openstack_lb_pool_v2.pool_1.id}"
  address       = "${openstack_compute_instance_v2.web1.network.0.fixed_ip_v4}"
  protocol_port = 80
}

resource "openstack_lb_member_v2" "member_2" {
  subnet_id     = "${openstack_networking_subnet_v2.internal_network_subnet.id}"
  pool_id       = "${openstack_lb_pool_v2.pool_1.id}"
  address       = "${openstack_compute_instance_v2.web2.network.0.fixed_ip_v4}"
  protocol_port = 80
}
