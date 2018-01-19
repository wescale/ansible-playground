# Exercices Formation Ansible by WeScale

# Pré-requis

* Installer Terraform (testé avec 0.9.3)
* Avoir un compte AWS et renseigner dans votre shell mes variables d'environnement AWS_* 
pour consommer l'API.
* Ne travailler que depuis la racine de ce workspace.
* Laissez vous guider par les éventuels messages d'erreur. Ils sont là pour une raison.

# Challenge

Sur votre machine :

* rapatrier et appliquer le role seed (aurelienmaury.seed) via ansible-galaxy

* poser un fact custom : /etc/ansible/facts.d/training.fact

{ "counter": 0 }

* constater sa présence par un playbook qui affiche (module debug) la valeur de {{ ansible_local.training.counter }}

* en vous inspirant du role prometheus-master, rédiger un rôle prometheus-node qui fait l'installation et la mise en service :

https://github.com/prometheus/node_exporter
version 0.15.2

* mettre en place une métrique custom

path:    {{ node_exporter_deploy_dir }}/txt/pull_count.prom
content: training_counter{owner="{{ ansible_user }}"} {{ ansible_local.training.counter }}

* faire un playbook qui incrémente le fact training.counter et met à jour la métrique training_counter

* installer votre playbook dans un repository git public, nommé local.yml

* le lancer sur votre machine cible avec une commande ansible-pull

* faire un playbook qui met en place un cron de cette commande ansible-pull


# NDR: sum by (job)(up{})
# NDR: training_counter{}