resource "random_string" "bucket_name" {
  length = 24
  lower  = true
  upper = false
  special = false
}

#this does the same thing as _result
#output "random_bucket_name_id" {
#  value = random_string.bucket_name.id
#}



resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

  tags = {
    UserUuid = var.user_uuid
    
  }
}
