data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "js_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "js_internet_gateway" {
  vpc_id = aws_vpc.js_vpc.id
}

resource "aws_subnet" "js_subnet" {
  vpc_id                  = aws_vpc.js_vpc.id
  cidr_block              = "10.0.${1 + count.index}.0/24"
  count                   = length(data.aws_availability_zones.available.names)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.js_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.js_internet_gateway.id
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(data.aws_availability_zones.available.names)
  subnet_id      = element(aws_subnet.js_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}