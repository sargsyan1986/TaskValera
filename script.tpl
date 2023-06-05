#! /bin/bash

./script.tpl


cd /tmp
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
rpm -U amazon-cloudwatch-agent.rpm



# for logs - Linux: /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log
# for config file - installation-directory/doc/amazon-cloudwatch-agent-schema.json
# mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
# touch /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

bash -c cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<EOF
{
  "agent": {
    "metrics_collection_interval": 60,
    "region": "us-east-1",
    "logfile": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
    "debug": false,
    "run_as_user": "cwagent"
  },
  "metrics": {
    "namespace": "MetricsForValera",
    "append_dimensions": {
      "InstanceId": "${curl http://169.254.169.254/latest/meta-data/instance-id}"
    },
    "metrics_collected": {
      "disk": {
        "measurement": [
          "used_percent"
        ],
        "resources": [
          "/"
        ],
        "metrics_collection_interval": 60
      },
      "mem": {
        "measurement": [
          "used_percent"
        ],
        "metrics_collection_interval": 60,
        "resources": [
          "/"
        ]
      }
    }
  }
}
EOF

# sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc && sudo touch /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json && sudo bash -c 'echo -e "{
# \"agent\": {
# \"metrics_collection_interval\": 60,
# \"run_as_user\": \"cwagent\"
# },
# \"metrics\": {
# \"append_dimensions\": {
# \"InstanceId\": \"\${aws:InstanceId}\"
# },
# \"metrics_collected\": {
# \"disk\": {
# \"measurement\": [
# \"used_percent\"
# ],
# \"metrics_collection_interval\": 60,
# \"resources\": [
# \"/\"
# ]
# },
# \"mem\": {
# \"measurement\": [
# \"used_percent\"
# ],
# \"metrics_collection_interval\": 60,
# \"resources\": [
# \"/\"
# ]
# }
# }
# }
# }" > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json'

sudo systemctl restart amazon-cloudwatch-agent


