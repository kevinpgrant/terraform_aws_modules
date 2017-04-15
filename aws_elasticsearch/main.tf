provider "aws" {
  region = "${var.aws_region}"
}


resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.aws_domain_name_es}"
  elasticsearch_version = "1.5"
  cluster_config {
    instance_type = "${var.aws_instance_type_es}"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = true
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_id}:root"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${var.aws_region}:${var.aws_account_id}:domain/${var.aws_domain_name_es}/*"
    }
  ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags {
  	Domain = "${var.aws_domain_name_es}"
    Terraform = "true"
  }
}