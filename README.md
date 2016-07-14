
# A simple CRUD/DB Testing Area

### Usage
```unix
  cd/"project-folder"
```
In Terminal
```unix
  bundle install
```

Before you do the migrations make sure you specified DB administrations in the database.yml file

```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: "Root User or New user"
  password: "Password"
  socket: /tmp/mysql.sock

development:
  <<: *default
  database: "db_name"

```

```unix
rake db:create db:migrate
```

Subjects
* id (primary key)
* name (string)
* position (string)
* visible (boolean)


Pages
* id (primary key)
* subject_id (integer)
* name (string)
* permalink (string)
* position (integer)
* visible (boolean)

Sections
* id (primary key)
* page_id (Foreign Key)
* name (string)
* position (string)
* visible (string)
* content_type (string)
* content (string)
