{
   "Version": "2012-10-17",
   "Id": "Policy1415115909152",
   "Statement": [
     {
       "Sid": "Access-to-specific-VPCE-only",
       "Principal": "*",
       "Action": "s3:*",
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