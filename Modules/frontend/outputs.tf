output "cloudfront_url" {
  description = "URL de la distribución CloudFront"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.static_assets.id
}