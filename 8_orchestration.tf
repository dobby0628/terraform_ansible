resource "openstack_orchestration_stack_v1" "stack_1" {
  name = "stack"
  parameters = {
    image               = "267974b3-7728-4fe7-8a0d-95280a2df66f"
    key                 = "dobbyisfree"
    flavor              = "${openstack_compute_flavor_v2.t2_small.name}"
    network             = "${openstack_networking_network_v2.internal_network.id}"
    subnet_id           = "${openstack_networking_subnet_v2.internal_network_subnet.id}"
    external_network_id = "${openstack_networking_network_v2.external_network.id}"
  }
  template_opts = {
    Bin = file("./auto_test.yaml")
  }
  environment_opts = {
    Bin = "\n"
  }
  disable_rollback = true
  timeout = 1000
}
