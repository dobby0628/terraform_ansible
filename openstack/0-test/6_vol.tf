<<<<<<< HEAD
# Create volume web1
resource "openstack_blockstorage_volume_v3" "CentOS7_vol" {
  region      = "RegionOne"
  name        = "CentOS7_vol"
  description = "first test volume"
  size        = 20
  image_id    = "${openstack_images_image_v2.CentOS7.id}"
}

# Create volume web2
resource "openstack_blockstorage_volume_v3" "CentOS7_vol2" {
  region      = "RegionOne"
  name        = "CentOS7_vol2"
=======
# Create volume db
resource "openstack_blockstorage_volume_v3" "db_vol" {
  region      = "RegionOne"
  name        = "db_vol"
>>>>>>> Final commit
  description = "first test volume"
  size        = 20
  image_id    = "${openstack_images_image_v2.CentOS7.id}"
}
