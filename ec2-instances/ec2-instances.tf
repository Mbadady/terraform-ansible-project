resource "aws_instance" "ec2-instance" {
  ami                     = var.ami
  instance_type           = "t2.micro"
  count = 3
 tags = {
   "Name" = "web-server-${count.index}"
 }

 key_name = "id_rsa"

 vpc_security_group_ids = [aws_security_group.ssh-access.id, aws_security_group.elb_sg.id]

 subnet_id = aws_subnet.my_subnet_1.id

 associate_public_ip_address = true

 provisioner "local-exec" {

  on_failure = continue
    command = "echo ${self.public_ip}  >> /vagrant/terraform/ansible/host-inventory"
    # command = "echo web-server-${count.index} ${self.public_ip}  >> /vagrant/terraform/ansible/host-inventory"
  }

  provisioner "local-exec" {
command = "ansible-playbook -i host-inventory main.yml"
working_dir = "/vagrant/terraform/ansible/"
}

}

resource "aws_key_pair" "ssh-key"{
  key_name   = "id_rsa"
  public_key = file("/home/vagrant/.ssh/id_rsa.pub")
}

output "publicIp" {
  value = aws_instance.ec2-instance.*.public_ip
}

output "dns-elb" {
  value = aws_alb.alt-school-assignment.dns_name
}