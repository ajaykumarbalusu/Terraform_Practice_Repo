provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "TestServer" {
    ami = "ami-02b64aa047cb5edf5"
    instance_type = "t3.micro"
    key_name = "testkey"
}