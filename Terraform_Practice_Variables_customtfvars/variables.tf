variable "ami_id" {
    description = "The AMI ID to use for the instance"

    default     = "ami-02b64aa047cb5edf5"
}

variable "instance_type" {

    description = "The type of instance to create"

    default     = "t3.micro"

    
}

variable "key_name" {
    description = "The name of the key pair to use for the instance"

    default     = "testkey"
}

variable "tags" {
    description = "A map of tags to assign to the resource"

    default     = {
        Environment = "Development"
        Project     = "TerraformPractice"
    }
}