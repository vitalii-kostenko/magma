#!/bin/sh
# Install packages in to base container (for now)
apk add --no-cache --update \
    gcc \
    git \
    bash \
    libffi-dev \
    openssl-dev \
    bzip2-dev \
    zlib-dev \
    readline-dev \
    sqlite-dev \
    docker-compose \
    linux-headers \
    build-base

export PYENV_HOME=/root/.pyenv

# Install pyenv, then install python versions
git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_HOME && \
    rm -rfv $PYENV_HOME/.git
export PATH=$PYENV_HOME/shims:$PYENV_HOME/bin:$PATH
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
pip install pyyaml
