# Use an official Ruby runtime as a parent image
FROM ruby:3.0.0

# Set up environment
ENV RAILS_ENV=development
ENV RAILS_SERVE_STATIC_FILES=true
ENV SECRET_KEY_BASE=1

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler -v "2.2.15"

RUN bundler install

COPY . ./

# Precompile assets
RUN bundle exec rails assets:precompile

RUN bundle exec rake app:update:bin

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 8880
EXPOSE 8880

# Configure the main process to run when running the image
CMD ["bundle", "exec", "rails", "s",  "-p", "8880","-b", "0.0.0.0"]