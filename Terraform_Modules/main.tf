

provider "aws" {
  
  region = "ap-south-1"

}


module "madhu-instance" {
  
  source = "./ec2-module"
  ami_id = "ami-0f559c3642608c138"
  instance_type = "t3.micro"
  key_name = "Linuxkey"
}