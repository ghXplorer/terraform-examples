provider "aws" {
  version = "~> 2.50"
  region = "eu-central-1"
}

module "ec2-instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "2.13.0"

  ami                    = "ami-0e342d72b12109f91"
  name                   = "Jenkins-terraform"
  instance_type          = "t2.micro"
  key_name               = "test-key-Frankfurt"
  vpc_security_group_ids = ["sg-02f7a96ca3ff0eebf"]
  subnet_id              = "subnet-00b45d4c"
  user_data              = <<-EOF
                           #!/bin/bash
                           apt -y update
                           apt install -y default-jre
                           TSTX="$(update-java-alternatives -l |  python3 -c 'import sys; print("\""+ sys.stdin.read().split()[2] + "\"")')"
                           echo "JAVA_HOME=$TSTX" >> /etc/environment
                           source /etc/environment
                           wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -
                           sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
                           apt -y update
                           apt install -y jenkins
                           EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}
