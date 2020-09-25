FROM elixir:1.10

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force && \
    mix local.rebar --force

# Compile the project
RUN mix do compile
CMD ["/app/docker-entrypoint.sh"]
