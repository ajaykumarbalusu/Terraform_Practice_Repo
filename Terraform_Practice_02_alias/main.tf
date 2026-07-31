provider "aws" {
    region = "us-east-2"
    alias = "us"
}

provider "aws" {
    region = "us-west-2"
    alias = "west"
}

# Instance creation in us-east-2 region

resource "aws_instance" "TestServer_01" {
    provider = aws.us
    ami           = "ami-028ba4d4ccb4b7b72"
    instance_type = "t3.micro"
    key_name = "Serverkey"

    tags = {
        Name = "TestServer_01"
    }
}

# Instance creation in us-west-2 region
resource "aws_instance" "TestServer_02" {
    provider = aws.west

    ami = "ami-0e0d2e3754385cbd3"
    instance_type = "t3.micro"
    key_name = "west_server_key"

    tags = {
        Name = "TestServer_02"
    }
}