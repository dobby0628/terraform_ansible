resource "openstack_images_image_v2" "CentOS7" {
  name             = "CentOS7"
<<<<<<< HEAD
  image_source_url = "https://openstack-image.s3.ap-northeast-2.amazonaws.com/centos7.qcow2"
=======
  image_source_url = "https://dobbybucket.s3.ap-northeast-2.amazonaws.com/centos7.qcow2"
>>>>>>> Final commit
  container_format = "bare"
  disk_format      = "qcow2"
  visibility	   = "public"
}
