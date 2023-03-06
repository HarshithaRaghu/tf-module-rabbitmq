# Creates SPOT Servers
resource "aws_spot_instance_request" "spot-server" {
  ami                     = data.aws_ami.lab-image.id
  instance_type           = "t3.micro"
  subnet_id               = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS[0]
  vpc_security_group_ids  = [aws_security_group.allow_app.id]
  wait_for_fulfillment    = true
  iam_instance_profile    = "b52-admin-role"

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}