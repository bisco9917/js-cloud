

resource "aws_instance" "js_instance" {
  ami           = data.aws_ami.js_ami.id
  instance_type = var.aws_instance_type
  count         = var.instance_count
  subnet_id     = element(aws_subnet.js_subnet.*.id, count.index)

  tags = {
    Name = "js-cloud-${count.index + 1}"
  }
}
