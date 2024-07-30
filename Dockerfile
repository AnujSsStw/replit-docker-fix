# Use an official Ruby runtime as a parent image
FROM ruby:3.0.0

# Set the working directory in the container
WORKDIR /app

COPY . .
RUN ls -la
RUN pwd && ls -la

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install



RUN mkdir -p bin
RUN bundle exec rails app:update:bin
RUN ls -la bin/
RUN chmod +x bin/* || true

# Precompile assets
RUN bundle exec rails assets:precompile

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

RUN pwd && ls -la
RUN mkdir -p bin
RUN bundle exec rails app:update:bin
RUN ls -la bin/
RUN chmod +x bin/* || true
RUN bundle exec rails -v
RUN which rails
RUN echo $PATH

# Configure the main process to run when running the image
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8880"]

# Expose port 8880
EXPOSE 8880