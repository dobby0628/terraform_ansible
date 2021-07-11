# Create network-secgroup
<<<<<<< HEAD
resource "openstack_networking_secgroup_v2" "web_secgroup" {
  name        = "web_secgroup"
  description = "Web hosting security group"
=======
resource "openstack_networking_secgroup_v2" "db_secgroup" {
  name        = "db_secgroup"
  description = "db security group"
>>>>>>> Final commit
}

# Edit rule : permit ssh
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
<<<<<<< HEAD
  security_group_id = "${openstack_networking_secgroup_v2.web_secgroup.id}"
}

# Edit rule : permit http
=======
  security_group_id = "${openstack_networking_secgroup_v2.db_secgroup.id}"
}

# Edit rule : permit mysql
>>>>>>> Final commit
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
<<<<<<< HEAD
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.web_secgroup.id}"
=======
  port_range_min    = 3306
  port_range_max    = 3306
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.db_secgroup.id}"
>>>>>>> Final commit
}
