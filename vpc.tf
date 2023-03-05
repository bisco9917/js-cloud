data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "salt_environment" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.salt_environment.id
}

resource "aws_subnet" "salt_public_subnet" {
  vpc_id     = aws_vpc.salt_environment.id
  cidr_block = "10.0.${1+count.index}.0/24"
  count = "${length(data.aws_availability_zones.available.names)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.salt_environment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_rta" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id = "${element(aws_subnet.salt_public_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.public_rt.id
}