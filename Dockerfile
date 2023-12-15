# syntax=docker/dockerfile:1.3
ARG APP_ROOT=/app
ARG RUBY_VERSION=3.2.2

################################################################################
# Base configuration
#
FROM ruby:$RUBY_VERSION-slim-bullseye AS builder-base
ARG APP_ROOT
ARG BUNDLER_VERSION=2.4.22
ARG BUNDLE_PATH=/bundler
ARG CONTENT_REPOSITORY_PATH=src/content
ARG NODE_MODULES_PATH=/app/node_modules
ARG PACKAGES_BUILD="build-essential nodejs git libxml2-dev yarn pandoc asciidoctor"

ENV BUNDLE_BIN="$BUNDLE_PATH/bin"
ENV BUNDLE_PATH=$BUNDLE_PATH
ENV CONTENT_REPOSITORY_PATH=$CONTENT_REPOSITORY_PATH
ENV PATH="$BUNDLE_BIN:$PATH"

WORKDIR $APP_ROOT

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get remove -y cmdtest && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y --no-install-recommends $PACKAGES_BUILD && \
    gem update --system && \
    gem install bundler --no-document -v $BUNDLER_VERSION

COPY Gemfile Gemfile.lock package.json yarn.lock $APP_ROOT/

################################################################################
# Production builder stage
#
FROM builder-base AS builder-production

ENV BUNDLE_DEPLOYMENT=1
ENV BUNDLE_WITHOUT='development:test'
ENV BRIDGETOWN_ENV=production

RUN bundle install --jobs 4 --retry 3 && yarn install

COPY . $APP_ROOT/

RUN bundle exec bin/bridgetown deploy

################################################################################
# Production image
#
FROM nginx:latest AS production
ARG APP_ROOT
ARG WEB_ROOT=/var/www/bridgetown/output

COPY --from=builder-production $APP_ROOT/output $WEB_ROOT
COPY deployment/nginx.conf /etc/nginx/conf.d/default.conf

################################################################################
# Development image
#
FROM builder-base AS development
ARG GEMS_DEV="pessimizer rerun"
ARG PACKAGES_DEV="zsh curl wget sudo"
ARG PACKAGES_RUNTIME="tzdata nodejs"
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update && apt-get upgrade -y && \
    <<<<<<< HEAD
    apt-get install -y --no-install-recommends $PACKAGES_DEV $PACKAGES_RUNTIME && \
    gem install $GEMS_DEV && \
    addgroup --gid $USER_GID $USERNAME && \
    adduser --home /home/$USERNAME --shell /bin/zsh --uid $USER_UID --gid $USER_GID $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    mkdir -p $BUNDLE_PATH && \
    mkdir -p $NODE_MODULES_PATH && \
    chown -R $USERNAME:$USERNAME $BUNDLE_PATH && \
    chown -R $USERNAME:$USERNAME $APP_ROOT
    =======
    apt-get install -y --no-install-recommends $PACKAGES_DEV $PACKAGES_RUNTIME && \
    gem install $GEMS_DEV && \
    addgroup --gid $USER_GID $USERNAME && \
    adduser --home /home/$USERNAME --shell /bin/zsh --uid $USER_UID --gid $USER_GID $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    mkdir -p $BUNDLE_PATH && \
    mkdir -p $NODE_MODULES_PATH && \
    chown -R $USERNAME:$USERNAME $BUNDLE_PATH && \
    chown -R $USERNAME:$USERNAME $APP_ROOT
    >>>>>>> 39d115c (WIP)

    USER $USERNAME

    RUN bundle install --jobs 4 --retry 3

    WORKDIR /home/$USERNAME
    RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)"
    WORKDIR $APP_ROOT
