# Create volume db
resource "openstack_blockstorage_volume_v3" "db_vol" {
  region      = "RegionOne"
  name        = "db_vol"
  description = "first test volume"
  size        = 20
  image_id    = "${openstack_images_image_v2.CentOS7.id}"
}
