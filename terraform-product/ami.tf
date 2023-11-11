resource "aws_ami" "k8s_master_ami" {
  name                = "k8s_master_ami"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  imds_support        = "v2.0" # Enforce usage of IMDSv2. You can safely remove this line if your application explicitly doesn't support it.
  ebs_block_device {
    device_name = "/dev/xvda"
	  volume_type = "gp2"
    volume_size = 20
	  delete_on_termination = true
  }
}

resource "aws_ami" "k8s_worker_ami" {
  name                = "k8s_worker_ami"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"
  imds_support        = "v2.0" # Enforce usage of IMDSv2. You can safely remove this line if your application explicitly doesn't support it.
  ebs_block_device {
    device_name = "/dev/xvda"
	  volume_type = "gp2"
    volume_size = 10
	  delete_on_termination = true
  }
}
