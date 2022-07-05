
#Creating S3bucket
resource "aws_s3_bucket" "gogreen" {
  bucket = "my-ggn-bucket-123"
  acl    = "private"
  lifecycle_rule {
    id      = "gogreen_quarterly_retention"
    prefix  = "folder/"
    enabled = true

    expiration {
      days = 90
    }
  }
  versioning {
    enabled = true
  }
}



resource "aws_s3_bucket" "gogreen-glacier-123" {
  bucket = "my-ggn-glacier-123"
  acl    = "private"
  lifecycle_rule {
    id      = "gogreen-glacier-123-fiveyears_retention"
    prefix  = "folder/"
    enabled = true

    expiration {
      days = 1825
    }

    transition {
      days          = 1
      storage_class = "GLACIER"
    }
  }
}








# route53domains registered domain

# resource "aws_route53domains_registered_domain" "gogreen_aws" {
#   domain_name = "www.gogreen.com"

# }

#Create route53_zone

resource "aws_route53_zone" "gogreen_aws" {
  name = "www.gogreen.com"


  tags = {
    Environment = "dev"
  }
}
# Creating EIP
resource "aws_eip" "eip_r53" {
  vpc = true
}


resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.gogreen_aws.zone_id
  name    = "www.gogreen.com"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.eip_r53.public_ip]
}

# # Creating cloudfront_distribution

# resource "aws_cloudfront_distribution" "s3_distribution" {
#   origin {
#     domain_name = aws_s3_bucket.a.bucket_regional_domain_name
#     origin_id   = aws_s3_bucket.a.id

#     s3_origin_config {
#       origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
#     }
#   }

#   enabled = true
#   #is_ipv4_enabled     = true
#   comment             = "Some comment"
#   default_root_object = "index.html"

#   logging_config {
#     include_cookies = false
#     bucket          = "mylogs.s3.amazonaws.com"
#     prefix          = "myprefix"
#   }

#   #aliases = ["mysite.example.com", "yoursite.example.com"]

#   default_cache_behavior {
#     allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = aws_s3_bucket.a.id

#     forwarded_values {
#       query_string = false

#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "allow-all"
#     min_ttl                = 0
#     default_ttl            = 3600
#     max_ttl                = 86400
#   }

#   # Cache behavior with precedence 0
#   ordered_cache_behavior {
#     path_pattern     = "/content/immutable/*"
#     allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#     cached_methods   = ["GET", "HEAD", "OPTIONS"]
#     target_origin_id = aws_s3_bucket.a.id

#     forwarded_values {
#       query_string = false
#       headers      = ["Origin"]

#       cookies {
#         forward = "none"
#       }
#     }

# min_ttl                = 0
# default_ttl            = 86400
# max_ttl                = 31536000
# compress               = true
# viewer_protocol_policy = "redirect-to-https"


# # Cache behavior with precedence 1
# ordered_cache_behavior {
#   path_pattern     = "/content/*"
#   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
#   cached_methods   = ["GET", "HEAD"]
#   target_origin_id = aws_s3_bucket.a.id

#   forwarded_values {
#     query_string = false

#     cookies {
#       forward = "none"
#     }
#   }

#   min_ttl                = 0
#   default_ttl            = 3600
#   max_ttl                = 86400
#   compress               = true
#   viewer_protocol_policy = "redirect-to-https"
# }

# price_class = "PriceClass_200"

# restrictions {
#   geo_restriction {
#     restriction_type = "whitelist"
#     locations        = ["US", "CA", "GB", "DE"]
#   }
# }

# tags = {
#   Environment = "production"
# }

# viewer_certificate {
#   cloudfront_default_certificate = true
# }
