# Ruby on Rails - Eco Benchmark

## Context

https://github.com/Boavizta/ecobenchmark-applicationweb-backend

## Application

### Generation

```
rails new ecobenchmark \
  --api \
  --database=postgresql \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-job \
  --skip-active-storage \
  --skip-action-cable \
  --skip-asset-pipeline \
  --skip-javascript \
  --skip-hotwire \
  --skip-test \
  --skip-system-test
```

### Specifities

#### Creation timestamp

To use `creation_date` as the creation timestamp instead of the Rails-default `created_at`, we set an alias in `app/models/application_record.rb`

```rb
class ApplicationRecord < ActiveRecord::Base
  # ...

  alias_attribute :created_at, :creation_date
end
```

#### Initial schema

Because database tables are already defined, we create the database schema with a database migration file present in the `db/migrations` folder.

The `if_not_exists` prevent the application to override the existing database.

#### Docker-Composer hostname

On the Docker-Compose network, the app is named "service", so the runner will make requests to "http://service:8080".

By default, Rails blocks unknown hosts, so we need to add it to the configuration, in `config/environments/development.rb`.

#### SQL requests implementation

To respect the contribution guidelines, we use custom classes (in `app/lib` folder) to generate the responses for the GET requests.

As for the POST requests, the SQL requests generated by the ORM are pretty much the same, the only minor difference is that the `id` attribute is not present in the INSERT INTO as an input, but as the output of the request.

Thus, the request `INSERT INTO account(id, login, creation_date) values ($1, $2, $3)` becomes `INSERT INTO account(login, creation_date) values ($2, $3) RETURNING id`.