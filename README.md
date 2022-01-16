# Z.ai Machine Learning Tracking Server

Based on Z.ai-customized version of MLFlow tracking server, to be deployed on serverless architectures.



## ENV

MLFLOW_SERVER_FILE_STORE : `<driver>://<username>:<password>@<host>:<port>/<database>`

MLFLOW_SERVER_ARTIFACT_ROOT : `s3://ARTIFACTS_BUCKET_NAME`



## Permissions

"Action": [
    "s3:GetObject",
    "s3:ListBucket",
],
"Resource": "arn:aws:s3:::BUCKET_NAME*"



{
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "ec2:AssignPrivateIpAddresses",
                "ec2:UnassignPrivateIpAddresses"
            ],
            "Resource": "*"

}



## VPC

The lambda function must be set in a VPC where target backend DB is located.
