#!/bin/sh

# I do not want to run docker-compose for four scripts each time I `docker compose up -d`
# Therefore, I'll be sane

sudo docker-compose up -d
sudo docker-compose exec -T db psql postgres postgres < ../scripts/entities.sql
sudo docker-compose exec -T db psql postgres postgres < ../scripts/ICs.sql
sudo docker-compose exec -T db psql postgres postgres < ../scripts/populate.sql
sudo docker-compose exec -T db psql postgres postgres < ../scripts/view.sql
# Nice
