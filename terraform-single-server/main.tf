provider "aws" {
    region = "us-east-2"
}
resource "aws_instance" "example" {
    ami = "ami-0fb653ca2d3203ac1"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
tags = {
    Name = "terraform-example"
}
user_data = <<-EOF
              #! binbash 
= "t2.micro" 
echo "Hello, World" > index.xhtml 
nohup busybox httpd -f -p ${var.server_port} & 
EOF
user_data_replace_on_change = true
}

resource "aws_security_group" instance {
name = "Terraform-example-instance"
ingress {
    protocol = "tcp"
    from_port = var.server_port
    to_port = var.server_port
    cidr_blocks= ["0.0.0.0/0"] 
}
}
variable "server_port" {
    description = "The port used for communication"
    type = number
    default = 8080
}
output "public_ip" {
    description = "Public IP address"
    value = aws_instance.example.public_ip
}