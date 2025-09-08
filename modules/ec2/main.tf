resource "aws_instance" "web" {
    ami =  "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
    instance_type = var.instance_type
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]
    associate_public_ip_address = true

    user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>${var.project}-${var.environment} EC2 is running</h1>" > /usr/share/nginx/html/index.html
              EOF 

    tags = {
        Name = "${var.project}-${var.environment}-instance" 
    } 
}