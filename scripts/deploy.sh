docker pull cptactionhank/atlassian-jira
docker run \
  --name note-nest-backend \
  --restart=always \
  -d \
  -p  8080:8080 \
  cptactionhank/atlassian-jira:latest
