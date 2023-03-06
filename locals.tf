locals {
    SSH_USER         = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USER"]
    SSH_PASSWORD     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASSWORD"]
}