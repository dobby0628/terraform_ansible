# Create volume db
resource "openstack_blockstorage_volume_v3" "db_vol" {
  region      = "RegionOne"
  name        = "db_vol"
  description = "first test volume"
  size        = 20
  image_id    = "267974b3-7728-4fe7-8a0d-95280a2df66f"
}
