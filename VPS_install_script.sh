#Build scrips

apt-get update && apt-get upgrade


sudo apt install unattended-upgrades

#Create the user, replacing example_user with your desired username. You’ll then be asked to assign the user a password:

adduser limited_user
# add the user to the sudo group so you’ll have administrative privileges:

adduser limited_user sudo

# add the ssh keys

ssh-copy-id limited_user@45.33.24.41

# Harden SSH

cp /etc/ssh/sshd_config /etc/ssh/sshd_config_original

# diasllow root login over ssh

sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

sudo echo 'AddressFamily inet' | sudo tee -a /etc/ssh/sshd_config

# restart shhd server
sudo systemctl restart sshd

# install UFW

sudo apt-get install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming

sudo ufw allow ssh
sudo ufw enable
sudo ufw logging on


