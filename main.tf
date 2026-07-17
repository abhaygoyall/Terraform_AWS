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
nohup busybox httpd -f -p 8080 & 
EOF
user_data_replace_on_change = true
}

resource "aws_security_group" instance {
name = "Terraform-example-instance"
ingress {
    protocol = "tcp"
    from_port = "8080"
    to_port = "8080"
    cidr_blocks= ["0.0.0.0/0"] 
}
}