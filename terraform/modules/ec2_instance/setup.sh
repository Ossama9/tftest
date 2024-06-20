#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

# Installer Go
sudo apt-get install -y golang

# Clonage du dépôt Git contenant le code de l'application
git clone https://github.com/NhiSty/Colibris.git

# Déplacement dans le répertoire du projet
cd Colibris/Back

# Compilation de l'application
go build -o myapp

# Démarrage de l'application
nohup ./myapp > app.log 2>&1 &
