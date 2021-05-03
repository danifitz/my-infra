# ############################################
# Here we define path to the actual script we
# want to run when instance is created.
# 
# script path:       scripts/volume.cfg
# some name:         shell-script
#
# ############################################
 
data "template_file" "user-data" {
  template = "${file("${path.module}/scripts/other.sh")}"
  vars {}
}