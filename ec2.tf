# Creates SPOT Servers
resource "aws_spot_instance_request" "spot-server" {
  ami                     = data.aws_ami.lab-image.id
  instance_type           = "t3.micro"
  subnet_id               = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[0]
  vpc_security_group_ids  = [aws_security_group.allow_rabbit.id]
  wait_for_fulfillment    = true
  iam_instance_profile    = "b52-admin-role"

  tags = {
    Name = "rabbitmq-${var.ENV}"
  }
}


# Installing RabbitMQ

resource "null_resource" "app" {

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = local.SSH_USER
      password = local.SSH_PASSWORD
      host     = element(local.ALL_INSTANCE_IPS, count.index)  
      }

      inline = [
          "ansible-pull -U https://github.com/b52-clouddevops/ansible.git -e MONGO_URL=${data.terraform_remote_state.db.outputs.MONGO_ENDPOINT} -e COMPONENT=${var.COMPONENT} -e DB_PASSWORD=RoboShop@1 -e ENV=${var.ENV} -e APP_VERSION=${var.APP_VERSION} -e ENV=dev robot-pull.yml"
        ]
    }

}
