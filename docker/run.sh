#!/bin/sh

# I do not want to run docker-compose for four scripts each time I `docker compose up -d`
# Therefore, I'll be sane

cat ../scripts/schema.sql ../scripts/ICs.sql ../scripts/populate.sql ../scripts/view.sql | _ docker-compose exec -T db psql postgres postgres
# Nice
