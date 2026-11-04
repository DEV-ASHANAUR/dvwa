terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "assets" {
  bucket = "dvwa-assets-public"
  acl    = "public-read"
}

resource "aws_s3_bucket_public_access_block" "assets" {
  bucket                  = aws_s3_bucket.assets.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_security_group" "web" {
  name        = "dvwa-web"
  description = "web and administration access"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "app" {
  identifier                          = "dvwa-db"
  engine                              = "mysql"
  engine_version                      = "5.7.44"
  instance_class                      = "db.t3.micro"
  allocated_storage                   = 20
  username                            = "admin"
  password                            = "mrm0LKlqkCWepPnhgx9bKjq9"
  publicly_accessible                 = true
  storage_encrypted                   = false
  skip_final_snapshot                 = true
  backup_retention_period             = 0
  iam_database_authentication_enabled = false
}

resource "aws_ebs_volume" "data" {
  availability_zone = "us-east-1a"
  size              = 20
  encrypted         = false
}

resource "aws_iam_policy" "admin" {
  name = "dvwa-admin"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
    }]
  })
}
