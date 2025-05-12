
    #!/bin/bash
    # wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

# install gnupg and curl if they are not already available:
sudo apt-get install gnupg curl

# MongoDB public GPG key, run the following command:
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor

  # Create the list file for Ubuntu 24.04 (Noble):
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list


# Reload the package database
sudo apt-get update

# Install MongoDB Community Server

sudo apt-get install -y mongodb-org



sudo systemctl start mongod


mongosh


#  # switch to the admin database
        use admin
        # create an admin user 
        db.createUser({ user: "newadmin", pwd: "newadmin123", roles: ["root"] })


# # sudo service mongo restart
