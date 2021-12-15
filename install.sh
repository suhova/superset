#!bin/bash
sudo groupadd docker && sudo usermod -aG docker $USER && sudo service docker start
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose; sudo chmod 0755 /usr/bin/docker-compose
docker-compose -f docker-compose-non-dev.yml up

#docker-compose exec superset pip install clickhouse-sqlalchemy
#docker-compose restart

#clickhouse+native://default@clickhouse:9000/wba