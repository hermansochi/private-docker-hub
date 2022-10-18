# Private Docker Registry for Ubuntu 22.04

0. rename provisioning/hosts.yml.dst to hosts.yml and edit.

1. install on VM:

>cd provisioning && make server


2. generate file htpasswd for Basic auth

>docker run --rm registry:2.6 htpasswd -Bbn username password > htpasswd

3. Copy SSH key for user deploy on VM. 

>make authorize


3. Deploy from project root:

>HOST=server_ip PORT=ssh_port HTPASSWD_FILE=htpasswd make deploy
