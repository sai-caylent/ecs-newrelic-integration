[{
            "essential": true,
            "image": "533243300146.dkr.ecr.us-east-2.amazonaws.com/newrelic/logging-firelens-fluentbit",
            "name": "log_router",
            "firelensConfiguration": {
                "type": "fluentbit",
                "options": {
                    "enable-ecs-log-metadata": "true"
                }
            }
         },
          {
            "essential": true,
            "name": "${name}-container-${environment}",
            "image": "${image}:latest",
            "cpu": 256,
            "memoryReservation": 512,
            "portMappings": [{
                "containerPort": 80,
                "hostPort":80,
                "protocol": "tcp"
            }],
            "environment": [{
                "name": "VERSION",
                "value": "V1"
            }],

             "logConfiguration": {
                 "logDriver":"awsfirelens",
                 "options": {
                    "Name": "newrelic"
                 },
                 "secretOptions": [{
                    "name": "apiKey",
                    "valueFrom": "arn:aws:secretsmanager:us-east-2:131578276461:secret:NewRelicLicenseKeySecret-tDqeTIeqo91T-tW3ZZS"
                 }]
            }
        },
        {
        "environment": [
          {
            "name": "NRIA_OVERRIDE_HOST_ROOT",
            "value": ""
          },
          {
            "name": "NRIA_IS_FORWARD_ONLY",
            "value": "true"
          },
          {
            "name": "FARGATE",
            "value": "true"
          },
          {
            "name": "NRIA_PASSTHROUGH_ENVIRONMENT",
            "value": "ECS_CONTAINER_METADATA_URI,ECS_CONTAINER_METADATA_URI_V4,FARGATE"
          },
          {
            "name": "NRIA_CUSTOM_ATTRIBUTES",
            "value": "{\"nrDeployMethod\":\"downloadPage\"}"
          }
        ],
        "secrets": [
          {
            "valueFrom": "arn:aws:secretsmanager:us-east-2:131578276461:secret:NewRelicLicenseKeySecret-tDqeTIeqo91T-tW3ZZS",
            "name": "NRIA_LICENSE_KEY"
          }
        ],
        "cpu": 256,
        "memoryReservation": 512,
        "image": "newrelic/nri-ecs:1.9.7",
        "name": "newrelic-infra"
      }]
      