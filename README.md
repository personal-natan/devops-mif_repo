## YOU CAN BUILD, PUSH, DEPLOY TO DOCKER AND KUBERNETES USING run.sh script.
```
Please put your argument using these options

Syntax: ./run [-b|-d|-s|-l|-h]
options:
-b  Build the docker image
-d  Deploy the service using docker-compose
-s  Stop docker-compose
-l  Deploy the service to k8s cluster
-h  Help
```

### BUILD AND PUSH AUTOMATICALLY
```
specify the repository !
for instance: 
./run.sh -b n1t1n1g1r1/devops-mif_images
```

### DEPLOY TO DOCKER COMPOSE
```
# docker-compose up -d
./run.sh -d

# docker-compose down
./run.sh -s
```

### DEPLOY TO KUBERNETES USING HELM CHART
```
# HELM_UNIT_NAME = "mifx"
# HELM_CHART_NAME = "mifx-helm-chart"
# NAMECPASE/REPOSITORY = "n1t1n1g1r1/devops-mif_images"

the complete comment should be like this
./run.sh -l $HELM_UNIT_NAME $HELM_CHART_NAME $NAMESPACE/REPOSITORY
```

## THERE IS ALSO ANSIBLE SCRIPT TO BUILD, PUSH, DEPLOY TO DOCKER-COMPOSE AND KUBERNETES
```
$ cd 05-ansible/
$ ansible-playbook main-prep.yaml

# docker-compose
$ ansible-playbook main-deploy-docker.yaml

# kubernetes&helm
$ ansible-playbook main-deploy-helm.yaml
```

## HOW TO USE TERRAFORM SCRIPT ?
```
$ cd 08-terraform
$ terraform init
$ terraform plan
$ terraform apply
```