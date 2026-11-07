# Repository Guidelines

## Project Structure

This Rails 8.1 API uses Ruby 3.4.4 and PostgreSQL. Models, controllers and JSON:API serializers live in `app/`. Schema and migrations live in `db/`; `lib/tasks/import.rake` imports The Economist CSV by edition and country. RSpec tests and factories live in `spec/`. Read `README.md` for endpoints and `DEPLOY.md` for production operations.

## Development and Checks

- `bundle install`: install locked dependencies, including Kamal deployment tooling.
- `DISABLE_SPRING=1 bin/rails db:prepare`: prepare the selected database.
- `DISABLE_SPRING=1 bin/rails import:run`: import official data; this accesses the network and writes records.
- `DISABLE_SPRING=1 bin/rails server -b 127.0.0.1 -p 3000`: serve the frontend's local API.
- `DISABLE_SPRING=1 bundle exec rspec`: run tests with SimpleCov output in `coverage/`.
- `DISABLE_SPRING=1 bin/rails zeitwerk:check`: verify autoloading.

## Style and Testing

Follow two-space Ruby indentation, snake_case methods and filenames, and CamelCase classes. Keep response serialization in serializers and data import logic in the task. Name tests `*_spec.rb` under the corresponding `spec/` directory. Preserve deterministic ordering, latest-edition selection and decimal serialization. One legacy model example is pending; no coverage threshold is configured.

## Production Deployment

The API is live at `https://bigmac-api.gurgelrenan.tech`; its frontend is `https://bigmac.gurgelrenan.tech`. Docker and Kamal publish the amd64 image to GHCR. Use `bin/kamal deploy` for application updates; PostgreSQL and the Nginx router are separate accessories. Startup runs `db:prepare`; imports remain a separate command.

Cloudflare and Traefik provide public routing and HTTPS through the shared Kamal proxy. Preserve the Fiscaliza services and existing proxy configuration. The frontend uses a same-origin `/api/` proxy. Back up PostgreSQL before migrations; rollback only replaces the application image. Automatic backups and scheduled imports are not configured.

## Security and Contributions

Never commit `.kamal/secrets`, environment credentials or Rails keys. API secrets must be distinct from Fiscaliza's. Use short, action-oriented commit subjects. PRs should describe behavior, tests, migrations and deployment effects. Compare countries within the same edition and preserve data-source attribution.
