data "template_file" "user-data" {
  template = "${file("${path.module}/scripts/other.sh")}"
  vars {}
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0a3f5ff1cb905da33" # Amazon Linux 2 AMI (HVM), SSD Volume Type eu-west-1
  instance_type = "t2.medium"
  key_name      = aws_key_pair.my_key_pair.key_name
  subnet_id = "${aws_subnet.my_subnet.id}"
  vpc_security_group_ids = [ "${aws_security_group.allow_ssh_and_egress.id}" ]
  user_data = "${data.template_file.user_data.rendered}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 100
  }
}

output "ec2_global_ips" {
  value = [
      "${aws_instance.my_instance.instance_state}",
      "${aws_eip.my_elastic_ip.public_ip}"
    ]
}