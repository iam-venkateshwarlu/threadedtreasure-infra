resource "aws_instance" "web" {
    ami =  "ami-00ca32bbc84273381" # Amazon Linux 2 AMI
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.security_group_id]
    associate_public_ip_address = true
    key_name = var.key_name

    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3
              echo "<h1>${var.project}-${var.environment} EC2 is running</h1>" > /usr/share/nginx/html/index.html
              EOF 

    tags = {
        Name = "${var.project}-${var.environment}-instance" 
    } 
}

