#!/bin/bash

sudo yum install amazon-cloudwatch-agent -y
cd /tmp
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U amazon-cloudwatch-agent.rpm
sudo bash -c cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<EOF
{
  "agent": {
    "metrics_collection_interval": 300,
    "run_as_user": "cwagent"
  },
  "metrics": {
    "append_dimensions": {
        "InstanceId": "${curl http://169.254.169.254/latest/meta-data/instance-id}"
    },
    "metrics_collected": {
      "disk": {
        "measurement": [
          "used_percent"
        ],
        "metrics_collection_interval": 300,
        "resources": [
          "/"
        ]
      }
    }
  }
}
EOF
sudo systemctl restart amazon-cloudwatch-agent
