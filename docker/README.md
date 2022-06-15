# Using Docker containers

Start the containers with

```
sudo docker-compose up -d
```

Stop the containers with

```
sudo docker-compose down
```

**pgadmin4** will be available at https://localhost:5050, with the following credentials:

- Username: `postgres@example.com`
- Password: `postgres`

The webserver (for the .cgi files) will be available at https://localhost:5051/.

Database credentials are

- Host: `db` inside the containers, `localhost:5432` outside
- Username: `postgres`
- Password: `postgres`

To use the postgres console through the docker console, run

```
sudo docker-compose exec db psql postgres postgres
```

Data for the database is stored at `/docker/db-data`, which can be deleted to reset the database.
