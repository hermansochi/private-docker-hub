# Private Docker Registry

1. install on VM:

>cd provisioning && make server

If you get error:
docker: Error response from daemon: cgroups: cgroup mountpoint does not exist: unknown.
ERRO[0031] error waiting for container: context canceled

Once run 
>mkdir /sys/fs/cgroup/systemd && mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
on server or once insert step:

>-   name: Fix for Error response from daemon cgroups cgroup mountpoint does not exist
>    shell: "mkdir /sys/fs/cgroup/systemd && mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd"

in provisioning\roles\registry\tasks\generate_certificates.yml

2. generate file htpasswd for Basic auth

>docker run --rm registry:2.6 htpasswd -Bbn username password > htpasswd

3. Copy SSH key for user deploy on VM. 

>make authorize


3. Deploy from project root:

>HOST=server_ip PORT=ssh_port HTPASSWD_FILE=htpasswd make deploy
