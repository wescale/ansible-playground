# Exercices Formation Ansible by WeScale

# Pré-requis

* Installer Terraform (testé avec 0.9.3)
* Avoir un compte AWS et renseigner dans votre shell mes variables d'environnement AWS_* 
pour consommer l'API.
* Ne travailler que depuis la racine de ce workspace.
* Laissez vous guider par les éventuels messages d'erreur. Ils sont là pour une raison.

# Challenge

Sur votre machine :

* Utiliser `ansible-galaxy` pour installer le role `aurelienmaury.seed` en le renommant en `seed` 
 
* Rédiger un playbook pour appliquer le rôle `seed` sur votre machine de training

* Créer un fact custom en créant le fichier `/etc/ansible/facts.d/training.fact` avec le contenu suivant :
```
{ "counter": 0 }
```

* Créer un playbook qui affiche la valeur de ce fact, via le module debug : 
```
{{ ansible_local.training.counter }}
```

* Créer un rôle prometheus-node qui réalise l'installation du projet [Node Exporter](https://github.com/prometheus/node_exporter). 
Cela passe par l'automatisation de :
    * création d'un groupe système `node_exporter`
    * création d'un utilisateur système `node_exporter`
    * récupération de la [dernière archive de release](https://github.com/prometheus/node_exporter/releases/download/v0.15.2/node_exporter-0.15.2.linux-amd64.tar.gz) (via le module [get_url](http://docs.ansible.com/ansible/latest/modules/get_url_module.html))
    * décompression (via le module [unarchive](http://docs.ansible.com/ansible/latest/modules/unarchive_module.html) sans oublier l'attribut `remote_src`)
    * création d'un service systemd pour lancer `node_exporter`, sur ce modèle-ci à déposer dans `/lib/systemd/system/node_exporter.service` :
```
[Unit]
Description=Prometheus Node Exporter
After=syslog.target network.target

[Service]
Type=simple
WorkingDirectory={{ node_exporter_deploy_dir }}
ExecStart={{ node_exporter_deploy_dir }}/node_exporter --collector.textfile.directory={{ node_exporter_deploy_dir }}/txt
User={{ node_exporter_user }}
Group={{ node_exporter_user }}
Restart=always

[Install]
WantedBy=multi-user.target
```
* Activer le service avec le module `systemd` en pensant à rafraîchir le daemon:
```
- service:
    name: node_exporter
    state: started
    enabled: yes
    daemon_reload: yes
```
* mettre en place une métrique personnelle, dont voici le chemin et le contenu sous forme de variables :
```
---
custom_metric_path: "{{ node_exporter_deploy_dir }}/txt/pull_count.prom"
custom_metric_content: "training_counter{owner="{{ ansible_user }}"} {{ ansible_local.training.counter }}"
```

* Créer un playbook qui incrémente le fact ansible `ansible_local.training.counter` et met à jour la métrique node_exporter.
 
* Installer votre playbook dans un repository git public, nommé `local.yml`

* Expérimenter `ansible-pull` pour le lancer manuellement depuis votre machine de training.

* Créer un playbook qui met en place un cron de cette commande ansible-pull
