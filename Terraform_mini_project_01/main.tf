
provider "aws" {
    region = "us-east-2"
    
}

# Create VPC - 10.1.0.0/16

resource "aws_vpc" "prod_vpc" {

    cidr_block = "10.1.0.0/16"

    tags = {
        Name = "Prod_vpc"
    }
}

# internet gateway creation

resource "aws_internet_gateway" "prod_igw" {

    vpc_id = aws_vpc.prod_vpc.id

}

# create a custom route table

resource "aws_route_table" "prod_rt" {

    vpc_id = aws_vpc.prod_vpc.id
    route {

        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod_igw.id
    }
    tags = {
        Name = "prod_rt"
    }
}

# create a public subnet - 10.1.1.0/24

resource "aws_subnet" "prod_subnet" {
    vpc_id = aws_vpc.prod_vpc.id
    cidr_block = "10.1.1.0/24"

    tags = {
        Name = "prod_subnet"
    }
}

# Associate the route table with the public subnet

resource "aws_route_table_association" "prod_rta" {
    subnet_id      = aws_subnet.prod_subnet.id
    route_table_id = aws_route_table.prod_rt.id
}

# Create security group to allow SSH and HTTP access

resource "aws_security_group" "prod_sg" {
    name = "prod_sg"
    vpc_id = aws_vpc.prod_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "prod_sg"
    }
}

#create an internet interface with an IP in the subnet

resource "aws_network_interface" "prod_eni" {
    subnet_id = aws_subnet.prod_subnet.id
    private_ips = ["10.1.1.10"] 
    security_groups = [aws_security_group.prod_sg.id]

    tags = {

        Name = "prod_eni"
    }

}

# Assign the public IP to the network interface

resource "aws_eip" "prod_eip" {
    
    network_interface = aws_network_interface.prod_eni.id
    domain = "vpc"

    tags = {
        Name = "prod_eip"
    }
}

# Create an EC2 instance and associate it with the network interface

resource "aws_instance" "prod_instance" {
    ami = "ami-028ba4d4ccb4b7b72"
    instance_type = "t3.micro"
    key_name = "Serverkey"

    network_interface {
        network_interface_id = aws_network_interface.prod_eni.id
        device_index = 0
    }

    user_data = file("Application.sh")

    tags = {
        Name = "prod_instance"
    }
}

output "prod_instance_public_ip" {
    value = aws_eip.prod_eip.public_ip
}