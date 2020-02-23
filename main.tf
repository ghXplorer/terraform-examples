provider "aws" {
  version = "~> 2.50"
  region = "eu-central-1"
}


resource "aws_instance" "example" {
  ami             = "ami-0df0e7600ad0913a9"
  instance_type   = "t2.micro"
  key_name        = "test-key-Frankfurt"

  tags = {
    Name = "terraform-example"
  }
}
