if [ -z "$ANSIBLE_VAULT_PASSWORD" ]; then
  echo "You must set the environment variable ANSIBLE_VAULT_PASSWORD."
  exit 1
fi

ansible-playbook \
    -M command \
    -i ./inventory/digitalocean \
    ./plays/backup.yml
