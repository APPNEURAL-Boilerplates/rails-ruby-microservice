ARG RUBY_VERSION=3.3.8
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

ENV BUNDLE_PATH=/usr/local/bundle \
    RAILS_ENV=production

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 && \
    rm -rf /var/lib/apt/lists/*

FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git pkg-config libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile ./
RUN bundle install

COPY . .
RUN bundle exec bootsnap precompile app/ config/ lib/ || true

FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

USER rails

EXPOSE 3000

CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
