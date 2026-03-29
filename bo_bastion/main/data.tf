data "aws_vpc" "tooling_vpc" {
  filter {
    name   = "tag:Name"
    values = ["bastion_vpc"]
  }
}

data "aws_subnet" "tooling_subnet_a" {
  vpc_id            = data.aws_vpc.tooling_vpc.id
  availability_zone = "${var.region}a"
  filter {
  name   = "tag:Name"
  values = ["bastion-subnet-a"]   # ← matches new tag
}
}

data "aws_subnet" "tooling_subnet_b" {
  vpc_id            = data.aws_vpc.tooling_vpc.id
  availability_zone = "${var.region}b"
}

data "aws_subnet" "tooling_subnet_c" {
  vpc_id            = data.aws_vpc.tooling_vpc.id
  availability_zone = "${var.region}c"
}