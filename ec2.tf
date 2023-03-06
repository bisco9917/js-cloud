resource "aws_instance" "js_instance" {
  ami                    = data.aws_ami.js_ami.id
  instance_type          = var.aws_instance_type
  vpc_security_group_ids = [aws_security_group.js_security_group.id]
  count                  = var.instance_count
  subnet_id              = element(aws_subnet.js_subnet.*.id, count.index)
  user_data              = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install apache2 -y
  echo "<h1>Hi, I'm part of js-cloud!  I'm $(curl http://checkip.amazonaws.com)</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "js-cloud-${count.index + 1}"
  }
}

output "instance_public_ip" {
  value = aws_instance.js_instance[*].public_ip
}