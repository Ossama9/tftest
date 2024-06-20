# EC2 Instance Module

## Description

Ce module Terraform est utilisé pour provisionner une instance EC2 AWS avec des configurations sécurisées de groupes de sécurité. Il installe et configure également un environnement Node.js sur cette instance, prêt à exécuter une application Express déployée depuis un dépôt Git.

## Structure des Fichiers

- **main.tf**: Contient la configuration principale pour la création de l'instance EC2 et du groupe de sécurité.
- **variables.tf**: Définit les variables requises pour la configuration du module.
- **outputs.tf**: Fournit les sorties du module, comme l'ID de l'instance et l'adresse IP publique.
- **setup.sh**: Script Bash utilisé pour installer et démarrer l'application Node.js sur l'instance EC2.

## Variables d'Entrée

| Nom               | Description                                        | Type   | Défaut          | Requis |
|-------------------|----------------------------------------------------|--------|-----------------|--------|
| `aws_region`      | La région AWS où déployer l'instance.              | string | `us-east-1`     | Non    |
| `instance_type`   | Le type de l'instance EC2.                         | string | `t2.micro`      | Non    |
| `ami_id`          | L'ID de l'AMI pour l'instance EC2.                 | string | -               | Oui    |
| `key_name`        | Le nom de la paire de clés AWS à utiliser.         | string | -               | Oui    |
| `private_key_path`| Le chemin vers la clé privée SSH sur la machine locale. | string | -          | Oui    |
| `public_key_path` | Le chemin vers la clé publique SSH.                | string | -               | Oui    |
| `ssh_user`        | Le nom d'utilisateur pour la connexion SSH.        | string | `ubuntu`        | Non    |
| `script_path`     | Le chemin vers le script d'installation de l'application. | string | `setup.sh`  | Non    |
| `tags`            | Les tags à appliquer à l'instance EC2.             | map    | `{}`            | Non    |

## Sorties

| Nom                | Description                                    |
|--------------------|------------------------------------------------|
| `instance_id`      | L'ID de l'instance EC2 créée.                  |
| `instance_public_ip`| L'adresse IP publique de l'instance EC2.      |


## Exemple d'utilisation

```hcl
module "ec2_instance" {
  source           = "./modules/ec2_instance"
  aws_region       = "us-east-1"
  instance_type    = "t2.micro"
  ami_id           = "ami-0c55b159cbfafe1f0"
  key_name         = "my-aws-key"
  private_key_path = "/path/to/my/private_key"
  public_key_path  = "/path/to/my/public_key.pub"
  ssh_user         = "ubuntu"
  script_path      = "modules/ec2_instance/setup.sh"
  tags             = {
    Name = "MyInstance"
  }
}
