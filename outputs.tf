output "bucket_name" {
  description = "Bucket name for static website hosting"
  value = module.home_contra_hosting.bucket_name
}

output "s3_website_endpoint"{
  description = "S3 static website hosting endpoint"
  value = module.home_contra_hosting.website_endpoint  
}

output "cloudfront_url" {
  description = "Cloudfront distribution domain name"
  value = module.home_contra_hosting.domain_name
}