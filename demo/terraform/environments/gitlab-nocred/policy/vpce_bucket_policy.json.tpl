{
   "Version": "2012-10-17",
   "Id": "Policy1415115909152",
   "Statement": [
     {
       "Sid": "Access-to-specific-VPCE-only",
       "Principal": "*",
       "Action": [
                "s3:AbortMultipartUpload",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:ListBucketMultipartUploads",
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
       "Effect": "Deny",
       "Resource": ["arn:aws:s3:::${bucket_name}",
                    "arn:aws:s3:::${bucket_name}/*"],
       "Condition": {
         "StringNotEquals": {
           "aws:sourceVpce": "${vpce}"
         }
       }
     }
   ]
}