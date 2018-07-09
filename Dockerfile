# The Google App Engine Ruby runtime is Debian Jessie with Ruby installed
# and various os-level packages to allow installation of popular Ruby
# gems. The source is on github at:
#   https://github.com/GoogleCloudPlatform/ruby-docker
FROM gcr.io/google_appengine/ruby

# Install 2.5.1 if not already preinstalled by the base image
RUN cd /rbenv/plugins/ruby-build && \
    git pull && \
    rbenv install -s 2.5.1 && \
    rbenv global 2.5.1 && \
    gem install -q --no-rdoc --no-ri bundler --version 1.16.2
ENV RBENV_VERSION 2.5.1

# Copy the application files.
COPY . /app/

# Install required gems.
RUN bundle install --deployment && rbenv rehash

# Set environment variables.
ENV RACK_ENV=production \
    RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    HELLO_KUBERNETES_DATABASE=hello_kubernetes_production \
    HELLO_KUBERNETES_DATABASE_USERNAME=posgres \
    HELLO_KUBERNETES_DATABASE_PASSWORD=BDvteGK7gu429t1E \
    HELLO_KUBERNETES_CONNECTION=/cloudsql/hello-kubernetes-209412:us-east1:hello-kubernetes


# Install yarn
RUN npm i -g yarn
RUN yarn install

# Run asset pipeline.
RUN bundle exec rake assets:precompile

# Reset entrypoint to override base image.
ENTRYPOINT []

# Use foreman to start processes. $FORMATION will be set in the pod
# manifest. Formations are defined in Procfile.
CMD bundle exec foreman start --formation "$FORMATION"
