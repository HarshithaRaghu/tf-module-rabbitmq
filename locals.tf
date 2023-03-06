locals {
    ALL_INSTANCE_IPS = concat(aws_spot_instance_request.spot-server.*.private_ip, aws_instance.my-ec2.*.private_ip)
    SSH_USER         = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USER"]
    SSH_PASSWORD     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASSWORD"]
}