# Projet de l'École sur Terraform et AWS

## Description du Projet

Ce projet consiste à déployer et gérer une application Node.js sur une instance EC2 d'AWS en utilisant Terraform. Le projet utilise un script d'initialisation pour configurer l'instance avec Node.js et lance une application Express qui est récupérée depuis un dépôt Git.

## Architecture

L'infrastructure déployée inclut :
- Une instance EC2
- Un groupe de sécurité permettant les accès SSH et HTTP
- Une paire de clés SSH pour la connexion sécurisée à l'instance

## Prérequis

- Terraform v0.12.x ou supérieur
- Compte AWS avec les permissions IAM adéquates
- AWS CLI configuré localement
- Clés SSH disponibles localement

## Structure des Fichiers

- `main.tf` : Contient la définition de l'instance EC2 et du groupe de sécurité.
- `variables.tf` : Définit toutes les variables utilisées dans les configurations.
- `outputs.tf` : Définit les sorties après le déploiement.
- `provider.tf` : Configure le provider AWS et la région.
- `/modules` : Liste des modules qui contient le module ec2_instance à utiliser

## Utilisation

Pour utiliser ce projet, suivez les étapes suivantes :

1. **Cloner le dépôt** :

```bash
git clone https://exemple.com/repo.git
cd repo
```

2. **Initialiser Terraform** :

```bash
terraform init
```


2. **Planifier Terraform** :

```bash
terraform plan
```


3. **Appliquer la configuration** :

```bash
terraform apply
```


4. **Accéder à l'application** :

Utilisez l'adresse IP publique fournie par les sorties de Terraform pour accéder à votre application via un navigateur ou SSH.


## Auteurs:
- CHERIGUI Amine
- DAHBI Ossama