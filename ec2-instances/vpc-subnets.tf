resource "aws_vpc" "my_assignment_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "My VPC"
  }
}

# resource "aws_subnet" "my_subnet" {
#   for_each = var.subnet
#   # vpc_id            = aws_vpc.my_assignment_vpc.id
#   vpc_id            = "${aws_vpc.my_assignment_vpc.id}"
#   cidr_block        = each.value.cidr
#   availability_zone = each.value.az

#   tags = {
#     # Name = "${each.key}"
#     Name = each.key
#   }
# }

resource "aws_subnet" "my_subnet_1" {
  vpc_id            = aws_vpc.my_assignment_vpc.id
  cidr_block        = "${var.subnet["subnet-a"].cidr}"
  availability_zone = "${var.subnet["subnet-a"].az}"
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id            = aws_vpc.my_assignment_vpc.id
  cidr_block        = "${var.subnet["subnet-b"].cidr}"
  availability_zone = "${var.subnet["subnet-b"].az}"
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_assignment_vpc.id

  tags = {
    Name = "My Internet Gateway"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_assignment_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "My Route Table"
  }
}
resource "aws_route_table_association" "public_route_table" {
  subnet_id      = aws_subnet.my_subnet_1.id
  route_table_id = aws_route_table.my_route_table.id
}