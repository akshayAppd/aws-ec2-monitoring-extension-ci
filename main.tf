provider "aws" {
  region     = "eu-central-1"
  shared_credentials_file = "creds"
  profile                 = "appdext"
}

resource "aws_instance" "aws_btd" {
  ami = "ami-09def150731bdbcc2"
  instance_type = "t2.micro"

  #Reading the subnet_id from variables.tf
  #subnet_id = "subnet-3c3bbb75"

  #Security group
  #security_groups = ["sg-ccb3ebb"]
}