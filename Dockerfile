ARG APP_ROOT=/app
ARG BUNDLE_PATH=/bundler
ARG PACKAGES_RUNTIME=""
ARG RUBY_VERSION="3.2.2"

################################################################################
# Base configuration
#
FROM ruby:$RUBY_VERSION-slim-bullseye AS builder-base
ARG APP_ROOT
ARG BUNDLE_PATH
ARG PACKAGES_BUILD="build-essential git"

ENV BUNDLE_PATH=$BUNDLE_PATH
ENV BUNDLE_BIN="$BUNDLE_PATH/bin"
ENV PATH="$BUNDLE_BIN:$PATH"

WORKDIR $APP_ROOT

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends $PACKAGES_BUILD && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    gem install bundler --no-document

COPY Gemfile Gemfile.lock $APP_ROOT/

################################################################################
# Development image
#
FROM builder-base AS development
ARG GEMS_DEV="pessimizer"
ARG PACKAGES_DEV="zsh curl wget sudo"
ARG PACKAGES_RUNTIME
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends $PACKAGES_DEV $PACKAGES_RUNTIME && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    gem install $GEMS_DEV && \
    addgroup --gid $USER_GID $USERNAME && \
    adduser --home /home/$USERNAME --shell /bin/zsh --uid $USER_UID --gid $USER_GID $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    mkdir -p $BUNDLE_PATH && \
    chown -R $USERNAME:$USERNAME $BUNDLE_PATH && \
    chown -R $USERNAME:$USERNAME $APP_ROOT

USER $USERNAME

RUN bundle install --jobs 4 --retry 3

WORKDIR /home/$USERNAME
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)"

WORKDIR $APP_ROOT
