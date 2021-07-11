resource "openstack_orchestration_stack_v1" "stack_1" {
  name = "stack_1"
  parameters = {
    image		= "257efd6f-0726-4cb1-9278-7a78517ae151"
    key			= "test"
    flavor		= "m1.small"
    network		= "67a13f2a-181f-400b-80ca-799c9343d83f"
    subnet_id		= "03986396-5c41-4af5-9758-8c81bfd66851"
    external_network_id = "a10ae738-8ae2-45fa-9ddb-6fcca3a4efe3"
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
