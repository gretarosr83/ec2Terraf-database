terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    profile = "default"
    region = "us-east-1"
}

resource "tls_private_key" "rsa_4096" {
    algorithm = "RSA"
    rsa_bits = 4096 
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.key_name}"
    public_key = tls_private_key.rsa_4096.public_key_openssh
    }

resource "local_file" "private_key" {
    content = tls_private_key.rsa_4096.private_key_pem
    filename = "${var.key_name}"
}

######################################
#creating EC2 instance
######################################
resource "aws_instance" "demo_instance" {
    ami = "${lookup(var.amis,var.region)}"
    instance_type = "t2.micro"
    key_name = aws_key_pair.key_pair.key_name
    //key_name = "demoKeyPair"
    # vpc_security_group_ids = ["sg-0d85898e4dbb0c7d2"]

    tags = {
      Name= "database_fscourse"
    }

  # user_data = file(backend_server.sh)

    provisioner "file" {
      source = "database.sh"
      destination = "/tmp/database.sh"

    }

    # provisioner "remote-exec" {
    #     inline = [ 
    #         "chmod +x /tmp/database.sh", #permision of the execution to the file
    #         "sudo /tmp/database.sh" #command to execute the file
    #      ]
    # }

  # SSH Configuration
    connection {
      host = "${aws_instance.demo_instance.public_ip}"
      user = "ubuntu"
      # private_key = "${file("${var.private_key_path}")}"
      private_key = "${file("${aws_key_pair.key_pair.key_name}")}"
    }
}   

resource "aws_security_group" "react_sg" {
    name="database_fscourse_sg"
    description = "Allow HTTP and SSH access"

      dynamic "ingress" {
        for_each = var.ingress_ports
        iterator = ports
        content {
            from_port   = ports.value
            to_port     = ports.value
            protocol    = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
        }

        
    }

     dynamic "egress" {
        for_each = var.egress_ports
        content {
            from_port   = egress.value
            to_port     = egress.value
            protocol    = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
        }

        
    }

}


