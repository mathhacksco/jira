#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

openssl aes-256-cbc \
    -K $encrypted_deae71ea1931_key \
    -iv $encrypted_deae71ea1931_iv \
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
  -v $(pwd)/deploy/ssh-keys:/root/.ssh \
  mathhacksco/jira

# clean up deploy key
git reset --hard HEAD
