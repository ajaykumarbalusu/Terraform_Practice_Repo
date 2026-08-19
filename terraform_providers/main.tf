resource "aws_instance" "web" {
  ami           = "ami-0332d564d76dbd8d6"
  instance_type = "t3.micro"

  tags = {
    Name = "terraform_providers"
  }
}
