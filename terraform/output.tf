output "Hostname" {
  value = "${aws_instance.frontend.*.public_dns}"
}


output "IP" {
  value = "${aws_instance.frontend.*.public_ip}"
}


output "SSH Key" {
  value = "${aws_instance.frontend.*.key_name}"
}


