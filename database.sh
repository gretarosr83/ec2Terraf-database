
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
sudo apt-get update -y

# Install MongoDB Community Server

sudo apt-get install -y mongodb-org



sudo systemctl start mongod

# Configuration file  path to remote access to the database
CONFIG_FILE="/etc/mongod.conf"

# New bindIp value
NEW_BIND_IP="0.0.0.0"

# Backup the original config file
sudo cp $CONFIG_FILE $CONFIG_FILE.bak

# Use sed to modify the bindIp line
sudo sed -i "s/bindIp:.*/bindIp: $NEW_BIND_IP/" $CONFIG_FILE

# Check if the change was successful
if grep "$NEW_BIND_IP" $CONFIG_FILE; then
  echo "Successfully updated bindIp to $NEW_BIND_IP"
  # Restart mongod service
  sudo service mongod restart
  echo "Mongod service restarted"
else
  echo "Failed to update bindIp.  Check the script and configuration file."
  # Restore the original config file if the update failed
  sudo cp $CONFIG_FILE.bak $CONFIG_FILE
  echo "Original config file restored."
fi


# mongosh
#  # switch to the admin database
        # use admin
        # db.createUser({ user: "newadmin", pwd: "newadmin123", roles: ["root"] })


 
# Copying databse script to instance
 # UBUNTU 
  sudo apt install git -y
    # git clone https://github.com/gretarosr83/reactReduxToolkit-.git /home/ec2-user/react-app
  sudo git clone https://github.com/gretarosr83/database.git /home/database


sudo apt install nodejs -y #Installs Node.js and its dependencies 
sudo apt install npm -y 

cd /home/database
sudo npm install
node script.js