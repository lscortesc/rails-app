# Rails App

First app created with Ruby on Rails

## Steps to run app

- If you are running Docker on Linux, the files rails new created are owned by root. This happens because the container runs as the root user. If this is the case, change the ownership of the new files.
`sudo chown -R $USER:$USER .`
- Run `docker-compose build`
- Run `docker-compose up`
- Create database `docker-compose run web rake db:create`
- Visit the app [here](http://localhost:3000)