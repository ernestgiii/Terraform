provider "aws" {
  region = "us-east-1"  
}

resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    tags = {
        Name = "dev"
    }


}

# Creating a Public Subnet In The VPC

resource "aws_subnet" "public-subnet" {
    vpc_id = "${aws_vpc.dev.id}" #interpolation example 
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "public-subnet"
    }
}

resource "aws_subnet" "public-subnet-2" {
    vpc_id = "${aws_vpc.dev.id}" #interpolation example 
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    tags = {
        Name = "public-subnet-2"
    }
}

# Creating a Internet Gateway In AWS VPC

resource "aws_internet_gateway" "dev-gw" {
    vpc_id = "${aws_vpc.dev.id}"
    tags = {
        Name = "dev-gw"
    }
}
  
# Creating Route Tables For Internet Gateway

resource "aws_route_table" "dev-public" {
    vpc_id = "${aws_vpc.dev.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.dev-gw.id}"
    }
    tags = {
        Name = "dev-public"
    }
}
