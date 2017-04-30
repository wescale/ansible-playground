output "bastion" {
  value = "${aws_instance.bastion.public_ip}"
}

output "classroom" {
  value = ["${aws_instance.classroom.*.private_ip}"]
}
