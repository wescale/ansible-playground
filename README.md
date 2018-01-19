# Exercices Formation Ansible by WeScale

# Pré-requis

* Installer Terraform (testé avec 0.9.3)
* Avoir un compte AWS et renseigner dans votre shell mes variables d'environnement AWS_* 
pour consommer l'API.
* Ne travailler que depuis la racine de ce workspace.
* Laissez vous guider par les éventuels messages d'erreur. Ils sont là pour une raison.

# Challenge

Sur votre machine :

* avec ansible-galaxy, rapatrier les roles prometheus-node-exporter
* appliquer prometheus-node-exporter
* mettre en place une métrique unitaire pour signaler la présence du serveur

path:    {{ node_exporter_deploy_dir }}/txt/training.prom
content: training{owner="{{ ansible_user }}"} 1

* ajouter un restart du démon en cas de modification du fichier
* rapatrier et appliquer le role seed
* mettre en place un cron qui lance un ansible-pull pour mettre à jour le fichier de variable et incrémenter un compteur

prometheus grafana mettre en place l'agent



