#!/bin/bash

# Mettre à jour le système
sudo apt update
sudo apt upgrade -y

# Installer Go
sudo apt install golang -y

git clone https://github.com/Ossama9/tftest.git

cd tftest/

go build -o back

nohup sudo ./back > back.log 2>&1 &
