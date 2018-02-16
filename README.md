# Rails App

First app created with Ruby on Rails

## Steps to run app

- Run `docker-compose run web rails new . --force --database=postgresql`
- If you are running Docker on Linux, the files rails new created are owned by root. This happens because the container runs as the root user. If this is the case, change the ownership of the new files.
`sudo chown -R $USER:$USER .`
- Run `docker-compose build`
- Config database connection on `config/database.yml` 
```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test
```
- Run `docker-compose up`
- Create database `docker-compose run web rake db:create`
- Visit the app [here](http://localhost:3000)