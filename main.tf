provider "aws" {
  version = "~> 2.50"
  region = "eu-central-1"
}


resource "aws_instance" "example" {
  ami                    = "ami-0df0e7600ad0913a9"
  instance_type          = "t2.micro"
  key_name               = "test-key-Frankfurt"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              wget https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64
              mv busybox-x86_64 busybox
              chmod +x busybox
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "terraform-example"
  }
}


resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
