data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "salt_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  count         = var.instance_count
  tags = {
    Name = "salt_instance-${count.index}"
  }
}
