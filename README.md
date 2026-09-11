# Quick Bike Rails

A Ruby on Rails port of [quick-bike-server](https://github.com/anpospisil/quick-bike-server), originally built with Express + Sequelize + PostgreSQL. This project recreates the same bike-reservation API — users, bikes, and reservations — using Rails conventions: ActiveRecord, migrations, and RSpec.

## Why this exists

Built as a hands-on way to get real experience with Ruby on Rails — models, migrations, associations, authentication, and testing — by porting an existing, well-understood project rather than starting from an unfamiliar domain. The goal was to compare idiomatic Rails patterns against the original Node/Express implementation, not just get something running.

## Tech Stack

- **Ruby on Rails** (API-only mode)
- **PostgreSQL**
- **RSpec** for testing
- **bcrypt** (`has_secure_password`) for password hashing
- **JWT** for token-based authentication, using Rails' encrypted credentials (`Rails.application.credentials.secret_key_base`) rather than a hardcoded secret

## Models

- **User** — `name`, `email` (unique), `password_digest`, `image_url`
- **Bike** — `name`, `latitude`, `longitude`, `reserved`
- **Reservation** — `start_time`, `end_time`, `cost`, belongs to `User` and `Bike`

## Getting Started

```bash
git clone <repo-url>
cd quick_bike_rails
bundle install
rails db:create
rails db:migrate
rails db:seed
```

## Running Tests

```bash
bundle exec rspec
```

## Notable Implementation Details

- **Authentication** uses Rails' `has_secure_password` for bcrypt hashing and a custom JWT encode/decode helper (`app/lib/json_web_token.rb`), signed with Rails' encrypted `secret_key_base` — never a hardcoded secret.
- **Query efficiency**: deliberately reproduced and fixed an N+1 query issue when loading reservations with their associated users — `Reservation.all.each { |r| r.user }` (~105 queries) vs. `Reservation.includes(:user).each { |r| r.user }` (2 queries), using ActiveRecord's `.includes` for eager loading.
- **Indexing**: foreign key columns (`user_id`, `bike_id`) are automatically indexed via Rails' `references` migration helper.

## Ported From

Original Node/Express/Sequelize implementation: [quick-bike-server](https://github.com/anpospisil/quick-bike-server)
Client (React/Redux/TypeScript): [quick-bike-client](https://github.com/anpospisil/quick-bike-client)

## What's Next

Continuing to explore idiomatic Rails patterns (scopes, concerns, service objects) beyond a straight port, and expanding RSpec coverage to request specs for the full auth + reservation flow.
