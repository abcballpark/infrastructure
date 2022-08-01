resource "aws_s3_bucket" "src" {
  bucket_prefix = "eb-src-${var.name}-"
}

resource "aws_s3_bucket_acl" "src" {
  bucket = aws_s3_bucket.src.id
  acl    = "private"
}

data "archive_file" "src_zip" {
  type = "zip"

  source_dir  = "${path.module}/src"
  output_path = "${path.module}/src.zip"
}

resource "aws_s3_object" "src_zip" {
  bucket = aws_s3_bucket.src.id

  key    = "src.zip"
  source = data.archive_file.src_zip.output_path

  etag = filemd5(data.archive_file.src_zip.output_path)
}
