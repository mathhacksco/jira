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
    -in ./ssh-keys/deploy_key.enc \
    -out ./ssh-keys/deploy_key -d
chmod 400 ./ssh-keys/deploy_key

if [ -z "$ANSIBLE_VAULT_PASSWORD" ]; then
  echo "You must set the environment variable ANSIBLE_VAULT_PASSWORD."
  exit 1
fi

docker build -t mathhacksco/jira $(pwd)

docker run \
  -e "ANSIBLE_VAULT_PASSWORD=$ANSIBLE_VAULT_PASSWORD" \
  -v $(pwd)/ssh-keys:/root/.ssh \
  mathhacksco/jira

# clean up deploy key
git reset --hard HEAD
