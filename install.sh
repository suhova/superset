#!bin/bash
sudo groupadd docker && sudo usermod -aG docker $USER && sudo service docker start
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose; sudo chmod 0755 /usr/bin/docker-compose
docker-compose -f docker-compose-non-dev.yml up

#docker-compose exec superset pip install clickhouse-sqlalchemy
#docker-compose restart
#docker exec -it clickhouse sh -c "clickhouse-client -n <<-EOSQL CREATE DATABASE IF NOT EXISTS wba; EOSQL"

docker exec -it clickhouse sh -c "clickhouse-client -n <<-EOSQL
    CREATE DATABASE IF NOT EXISTS wba;
    CREATE TABLE IF NOT EXISTS economic_policy_prediction(country_name String, time UInt32, gdp_growth_annual Float32) ENGINE = ReplacingMergeTree ORDER BY (country_name, time);
    CREATE TABLE IF NOT EXISTS economic_data(country_name String, country_code String, indicator_name String, indicator_code String, time UInt32, value Float32) ENGINE = ReplacingMergeTree ORDER BY (country_name, indicator_name, time);
EOSQL"


#clickhouse+native://default@clickhouse:9000/wba