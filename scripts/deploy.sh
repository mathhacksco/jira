# Install docker (if not already installed)
if ! [ -x "$(command -v docker)" ]; then
  echo "Docker already installed, continuing..."
else
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  echo "deb http://archive.ubuntu.com/ubuntu xenial main universe multiverse" > /etc/apt/sources.list
  wget -qO- https://get.docker.com/ | sh
fi

# Allocate a swapfile
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

docker pull cptactionhank/atlassian-jira
docker stop jira
docker rm jira
docker run \
  --name jira \
  --restart=always \
  -d \
  -p 80:8080 \
  cptactionhank/atlassian-jira:latest
