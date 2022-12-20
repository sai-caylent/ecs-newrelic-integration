[{
        "portMappings": [
          {
            "hostPort": 80,
            "protocol": "tcp",
            "containerPort": 80
          }
        ],
        "name": "${name}-container-${environment}",
        "image": "${image}:latest",

        "logConfiguration": {
	      "logDriver": "awslogs",
	      "options": {
		            "awslogs-group": "f45task",
		            "awslogs-region": "us-east-2",
		            "awslogs-stream-prefix": "f45ecs",
                "awslogs-create-group": "true"
		               }
            }}
      ]