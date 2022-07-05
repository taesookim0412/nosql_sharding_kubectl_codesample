# ~~1. Install Mongodb.
# (Make sure it is the right version)
wget https://raw.githubusercontent.com/taesookim0412/shell-scripts/main/install-mongodb.sh
sudo sh ./install-mongodb.sh


# 1-1. Set up config server:

sudo nano /etc/mongod.conf

# change configs

port: 27019
bindIp: localhost,configIp

replication:
  replSetName: "shard1config1"

sharding:
  clusterRole: configsvr

sudo service mongod stop

# DO NOT DO THE FOLLOWING:
# mongod --config /etc/mongod.conf

# Instead, use:

systemctl service restart mongod
sudo unlink /tmp/mongodb-27107.sock


sudo systemctl restart mongod
sudo systemctl status mongod

# 1-2. Initiate the config replica set (or a single config replica):

mongo localhost:27017

rs.status()
rs.config()

rs.initiate(
  { _id: "shard1config", 
  configsvr: true,
  members: 
  [
    {_id: 0, host: "10.0.0.81:27019" }
  ]
  }
  )


if we need to force a reconfig:

rs.reconfig(  
  { _id: "shard1config", 
  configsvr: true,
  members: 
  [
    {_id: 0, host: "10.0.0.81:27019" }
  ]
  } ,
{"force": true })




2. On Shards:

port: 27018
bindIp: localhost,privateIp

replication:
  replSetName: "shard1"

sharding:
  clusterRole: shardsvr

rs.initiate(  
  { _id: "shard1", 
  members: 
  [
    {_id: 0, host: "10.0.0.88:27018" },
    {_id: 1, host: "10.0.0.198:27018" }
  ]
  })

rs.initiate(  
  { _id: "shard1", 
  members: 
  [
    {_id: 0, host: "10.0.0.88:27018" },
    {_id: 1, host: "10.0.0.198:27018" }
  ]
  })

rs.reconfig(  
  { _id: "shard1", 
  members: 
  [
    {_id: 0, host: "10.0.0.88:27018" },
    {_id: 1, host: "10.0.0.198:27018" }
  ]
   } ,
{"force": true })




2. On router server:

# Disable mongodb.

sudo systemctl stop mongod

sudo systemctl disable mongod

# create log file and run mongos as a daemon, using the log file.

sudo touch /var/log/mongodb/mongos.log

#sudo mongos --configdb shard1config1/10.0.0.81:27019 --fork --logpath /var/log/mongodb/mongos.log
sudo mongos --configdb shard1config1/10.0.0.81:27019 --fork --logpath /var/log/mongodb/mongos.log --bind_ip localhost,10.0.0.71



ensure it works

mongo


# the other way is creating the mongos.conf

touch /etc/mongos.conf

sharding:
  configDB: shard1config1/10.0.0.81:27019
net:
  bindIp: localhost,10.0.0.71

mongos --config /etc/mongos.conf

#it should have connected to mongos.

# run as a daemon via fork.

# automate logfile rotations via https://www.percona.com/blog/2018/09/27/automating-mongodb-log-rotation/ (TODO)

# view shard status
sh.status()

# empty list of connected shards.

sh.addShard("shard1/10.0.0.88:27018")
sh.addShard("shard1/10.0.0.198:27018")

sh.status()

# enable sharding for "happyclassifier" database

sh.enableSharding("happyclassifier")
