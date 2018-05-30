#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

if [ -z "$OPENSSL_KEY" ]; then
  echo "You must set the environment variable OPENSSL_KEY."
  exit 1
fi

if [ -z "$OPENSSL_IV" ]; then
  echo "You must set the environment variable OPENSSL_IV."
  exit 1
fi

openssl aes-256-cbc \
    -K $OPENSSL_KEY \
    -iv $OPENSSL_IV \
    -in ./ssh-keys/deploy_key \
    -out ./ssh-keys/deploy_key.enc