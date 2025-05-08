# Bucket S3 para archivos estáticos
resource "aws_s3_bucket" "static_assets" {
  bucket = "${var.bucket_name}-${var.environment}"
  tags = {
    Environment = var.environment
  }
}

# Política para hacer el bucket público (solo lectura)
resource "aws_s3_bucket_policy" "static_policy" {
  bucket = aws_s3_bucket.static_assets.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = ["${aws_s3_bucket.static_assets.arn}/*"]
      }
    ]
  })
}

# Distribución CloudFront
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.static_assets.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.static_assets.id}"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.static_assets.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true  # Usa certificado gratis de CloudFront
  }

  tags = {
    Environment = var.environment
  }
}