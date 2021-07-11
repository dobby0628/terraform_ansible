# Create flavor t2.small
resource "openstack_compute_flavor_v2" "t2_small" {
  name          = "t2.small"
  ram           = "2048"
  vcpus         = "2"
  disk          = "20"
  flavor_id     = "6"
  is_public     = true

  extra_specs = {
    "hw:cpu_policy"        = "dedicated",
    "hw:cpu_thread_policy" = "isolate"
  }
}
