
    #!/bin/bash
    wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

sudo apt-get install gnupg

wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

sudo apt-get update

sudo apt-get upgrade


sudo apt-get install -y mongodb-org


echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections


sudo systemctl start mongod

# Only run these command in case some issue
# sudo systemctl daemon-reload

sudo systemctl status mongod

# sudo systemctl enable mongod
# sudo systemctl restart mongod



mongosh

# Switch to the dbnew database
# use dbnew

 # switch to the admin database
        use admin
        # create an admin user 
        db.createUser({ user: "newadmin", pwd: "newadmin123", roles: ["root"] })


# SET MONGO TO ACCESS GLOBALLY

# 1. NEED TO CHANGE IN /etc/mongod.conf

#     sudo vim /etc/mongod.conf

#     net:
#     port: 27017
#     bindIp: 0.0.0.0 

# After configured mongo.conf file run this command
# sudo service mongo restart
