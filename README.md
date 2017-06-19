### Happy Chauffeur

## installation

```
cd compose
docker-compose up -d
```

* Ruby version

2.4.1p111

* System dependencies

```bash
heroku buildpacks:set https://github.com/cyberdelia/heroku-geo-buildpack.git
heroku buildpacks:add heroku/ruby
```

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

- Data from: https://www.insee.fr/fr/statistiques/2520034
- Transform `.dbf` to `.csv` by `dbf2csv`
- Split large `.csv` on http://www.textfilesplitter.com/

* ...
