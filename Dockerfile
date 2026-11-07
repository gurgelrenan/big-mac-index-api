# syntax=docker/dockerfile:1
FROM ruby:3.4.4-slim AS base
WORKDIR /rails
ENV RAILS_ENV=production BUNDLE_DEPLOYMENT=1 BUNDLE_PATH=/usr/local/bundle BUNDLE_WITHOUT=development:test DISABLE_SPRING=1
RUN apt-get update -qq && apt-get install --no-install-recommends -y curl libpq5 && rm -rf /var/lib/apt/lists/*
FROM base AS build
RUN apt-get update -qq && apt-get install --no-install-recommends -y build-essential libpq-dev libyaml-dev && rm -rf /var/lib/apt/lists/*
COPY Gemfile Gemfile.lock ./
RUN bundle install && rm -rf /usr/local/bundle/cache
COPY . .
FROM base
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails
RUN groupadd --system --gid 1000 rails && useradd rails --uid 1000 --gid 1000 --create-home && mkdir -p log tmp storage && chown -R rails:rails log tmp storage db
USER 1000:1000
EXPOSE 3000
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
