resource "aws_instance" "web" {
  ami           = "ami-0332d564d76dbd8d6"
  instance_type = var.instance_type

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}
