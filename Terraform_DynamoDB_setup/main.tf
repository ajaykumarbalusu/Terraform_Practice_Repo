terraform { 
backend "s3" { 
bucket         
key            
region         
= "company-tfstate" 
= "prod/network/terraform.tfstate" 
= "ap-south-1" 
dynamodb_table = "tf-lock" 
encrypt = true        
} 
}
