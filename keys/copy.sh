# update
sudo apt update
sudo apt install python3 python3-pip git -y
pip3 install -r requirements.txt

# cp keys
\cp -f id_rsa ~/.ssh/
\cp -f id_rsa.pub ~/.ssh/
\cp -f id_rsa.pub ~/.ssh/authorized_keys
