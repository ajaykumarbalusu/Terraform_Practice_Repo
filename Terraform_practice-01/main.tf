provider "aws" {
    region = "us-east-2"

}

resource "aws_instance" "TestServer" {
    ami           = "ami-028ba4d4ccb4b7b72"
    instance_type = "t3.micro"
    key_name = "Serverkey"

    tags = {
        Name = "TestServer"
    }
}