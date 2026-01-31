#!/bin/bash
cd /home/ec2-user
sudo yum update -y
sudo yum install docker containerd git screen -y
sleep 1
sudo wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
sleep 1
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/libexec/docker/cli-plugins/docker-compose
sleep 1
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose
sleep 5
sudo systemctl enable docker.service --now
sudo usermod -a -G docker ssm-user
sudo usermod -a -G docker ec2-user
sudo systemctl restart docker.service
sudo docker pull karthik0741/images:petclinic_img
sudo docker run -e SPRING_DATASOURCE_URL=jdbc:mysql://${mysql_url}/petclinic -e SPRING_DATASOURCE_USERNAME=petclinic -e SPRING_DATASOURCE_PASSWORD=petclinic -e SPRING_PROFILES_ACTIVE=mysql -p 80:8080 docker.io/karthik0741/images:petclinic_img
