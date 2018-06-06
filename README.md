### Quickstart

To use this you need Docker and Docker Compose installed.

Run the following command to get setup:
```
wget https://raw.githubusercontent.com/JJTC-Docker/bookstack/master/bookstack.sh
chmod +x bookstack.sh
./bookstack.sh

```

#### Docker Compose Start/Stop
After bookstack.sh has taken care of the setup you can use the default docker-compose commands to start and stop:

```
#  Start as daemon
docker-compose up -d

# Stop
docker-compose down
```